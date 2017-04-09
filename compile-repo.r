#!/usr/bin/env perl

# Author: @nullriver & @AppleBetasDev
# Purpose: Compiles a Cydia repository & its corresponding depiction pages

use Digest::MD5;
use File::Path qw(make_path remove_tree);
use Sort::Versions;

# Specify your base repo URL to use as a base for depictions
$repoURL = "https://dr1ppnvv5.github.io";

sub md5sum {
    my $file = shift;
    my $digest = "";
    eval {
        open(FILE, $file) or die "Can't find file $file\n";
        my $ctx = Digest::MD5->new;
        $ctx->addfile(*FILE);
        $digest = $ctx->hexdigest;
        close(FILE);
    };
    if ($@) {
        print $@;
        return "";
    }
    return $digest;
}

sub trim { my $s = shift; $s =~ s/^\s+|\s+$//g; return $s };
sub replace_all { my ($find, $replace, $s) = @_; my $find = shift; my $replace = shift; $s =~ s/\Q$find\E/$replace/g; return $s; }

sub parseChangelog {
  my $clTxt = shift;
  my $newTxt = "<ul>";
  foreach $str (split(/\n/, $clTxt)) {
    $newTxt = $newTxt . "<li>" . $str . "</li>";
  }
  $newTxt = $newTxt . "</ul>";
}

# build packages into deb/
system("chmod -R 0755 uncompiled-packages/");

my $directory = 'uncompiled-packages/';
opendir (DIR, $directory) or die $!;
while (my $file = readdir(DIR)) {
  if($file eq "." or $file eq ".." or $file eq ".DS_Store") {
    next;
  }
	system("find . -name ".DS_Store" -delete && dpkg-deb -Zgzip -b uncompiled-packages/".$file." deb/".$file.".deb");
}
closedir(DIR);

# scan the packages and write output to file Packages
system("dpkg-scanpackages deb / > Packages");

# calculate the hashes and write to Release
system("cp Release-Template Release");
open(RLS, ">>Release");

@files = ("Packages", "Packages.bz2");
my $output = "";

foreach (@files) {
 	my $fname = $_;
	my $md5 =  md5sum($fname);
	my $size = -s $fname;
	$output = $output.$md5." ".$size." ".$fname."\n";
};

# Remove existing depiction files
system("rm -rf depiction/; mkdir depiction;");

# Get package info now
opendir (DEB_Dir, "deb/") or die $!;
open(PKGHTML, ">packages.html");
if (open(my $fh, '<:encoding(UTF-8)', "compile-inc/packages_header.html")) {
  while (my $row = <$fh>) {
    chomp $row;
    print PKGHTML "$row\n";
  }
}
$depictionHeader = "";
$depictionFooterAddon = "";
if (open(my $fh, '<:encoding(UTF-8)', "compile-inc/depiction_header.html")) {
  while (my $row = <$fh>) {
    chomp $row;
    $depictionHeader = $depictionHeader . "$row\n";
  }
}
if (open(my $fh, '<:encoding(UTF-8)', "compile-inc/depiction_footer_addon.html")) {
  while (my $row = <$fh>) {
    chomp $row;
    $depictionFooterAddon = $depictionFooterAddon . "$row\n";
  }
}
$changelogHeader = "";
if (open(my $fh, '<:encoding(UTF-8)', "compile-inc/changelog_header.html")) {
  while (my $row = <$fh>) {
    chomp $row;
    $changelogHeader = $changelogHeader . "$row\n";
  }
}
$miscFooter = "";
if (open(my $fh, '<:encoding(UTF-8)', "compile-inc/misc_footer.html")) {
  while (my $row = <$fh>) {
    chomp $row;
    $miscFooter = $miscFooter . "$row\n";
  }
}
$screenshotsHeader = "";
if (open(my $fh, '<:encoding(UTF-8)', "compile-inc/screenshots_header.html")) {
  while (my $row = <$fh>) {
    chomp $row;
    $screenshotsHeader = $screenshotsHeader . "$row\n";
  }
}
$screenshotsFooterAddon = "";
if (open(my $fh, '<:encoding(UTF-8)', "compile-inc/screenshots_footer_addon.html")) {
  while (my $row = <$fh>) {
    chomp $row;
    $screenshotsFooterAddon = $screenshotsFooterAddon . "$row\n";
  }
}
while (my $file = readdir(DEB_Dir)) {
  if($file eq "." or $file eq ".." or $file eq ".DS_Store") {
    next;
  }
  my $packageName = trim(`dpkg -f deb/$file Name`);
  my $packageVersion = trim(`dpkg -f deb/$file Version`);
  my $packageID = trim(`dpkg -f deb/$file Package`);
  my $filenamePortion = lc $packageID;
  my $depictionFolder = "depiction/" . $filenamePortion . "/";
  my $depictionFilename = $depictionFolder . "index.html";
  my $changelogFilename = $depictionFolder . "changelog.html";
  my $screenshotsFilename = $depictionFolder . "screenshots.html";
  my $changelogsDir = "package-data/" . $filenamePortion . "/changelogs/";
  my $screenshotsDir = "package-data/" . $filenamePortion . "/screenshots/";
  my $iconFilename = "package-data/" . $filenamePortion . "/icon.png";
  system("mkdir " . $depictionFolder);
  my $description = "<p>" . trim(`dpkg -f deb/$file Description`) . "</p>";
  if (open(my $fh, '<:encoding(UTF-8)', "package-data/" . $filenamePortion . "/description.html")) {
    $description = "";
    while (my $row = <$fh>) {
      chomp $row;
      $description = $description . "$row\n";
    }
  }
  my $currentChangelog = "";
  my %changelogs = ();
  my $hasOtherChangelogs = 0;
  if(opendir (Changelog_Dir, $changelogsDir)) {
    while(my $clFile = readdir(Changelog_Dir)) {
      if($clFile eq "." or $clFile eq ".." or $clFile eq ".DS_Store" or index($clFile, ".txt") == -1) {
        next;
      }
      my $clVersion = replace_all(".txt", "", $clFile);
      my $clTxt = "";
      if (open(my $fh, '<:encoding(UTF-8)', $changelogsDir . $clFile)) {
        while (my $row = <$fh>) {
          chomp $row;
          $clTxt = $clTxt . "$row\n";
        }
      }
      if($clFile eq $packageVersion . ".txt") {
        $currentChangelog = $clTxt;
      } else {
        $hasOtherChangelogs = 1;
      }
      $changelogs{$clVersion} = $clTxt;
    }
    closedir(Changelog_Dir);
  }
  my @screenshots = ();
  my $hasScreenshots = 0;
  if(opendir (SSDir, $screenshotsDir)) {
    while(my $ssFile = readdir(SSDir)) {
      if($ssFile eq "." or $ssFile eq ".." or $ssFile eq ".DS_Store") {
        next;
      }
      $hasScreenshots = 1;
      push @screenshots, $ssFile;
    }
    closedir(SSDir);
  }
  open(DEPHTML, ">", $depictionFilename);
  print DEPHTML replace_all("{PACKAGE_NAME}", $packageName, $depictionHeader);
  if($description ne "") {
    print DEPHTML "<h2 role=\"header\">Description</h2>
    <ul>
      <li>" . $description . "</li>
    </ul>";
  }
  if($hasScreenshots) {
    print DEPHTML "<ul><li><a href=\"screenshots.html\" role=\"button\" class=\"cydia_blank\">View Screenshots</a></li></ul>";
    open(SSHTML, ">", $screenshotsFilename);
    print SSHTML replace_all("{PACKAGE_NAME}", $packageName, $screenshotsHeader);
    foreach my $screenshotFile (@screenshots) {
      print SSHTML "<li><img src=\"/" . $screenshotsDir . $screenshotFile . "\" class=\"screenshot-image\"></li>";
    }
    print SSHTML replace_all("{PACKAGE_NAME}", $packageName, $screenshotsFooterAddon);
    print SSHTML replace_all("{PACKAGE_NAME}", $packageName, $miscFooter);
  }
  if($currentChangelog ne "" or $hasOtherChangelogs) {
    print DEPHTML "<h2 role=\"header\">Changelog</h2>
    <ul>";
    if($currentChangelog ne "") {
      print DEPHTML "<li>
        <p><strong>Changes in version " . $packageVersion . ":</strong></p>
        <p>" . parseChangelog($currentChangelog) . "</p>
      </li>";
    }
    if($hasOtherChangelogs) {
      print DEPHTML "<li><a href=\"changelog.html\" role=\"button\" class=\"cydia_blank\">View Previous Versions</a></li>";
    }
    print DEPHTML "</ul>";
    open(CLHTML, ">", $changelogFilename);
    print CLHTML replace_all("{PACKAGE_NAME}", $packageName, $changelogHeader);
    foreach my $version (reverse(sort versioncmp keys %changelogs)) {
      $changes = $changelogs{$version};
      print CLHTML "<li>
        <p><strong>Version " . $version . ":</strong></p>
        <p>" . parseChangelog($changes) . "</p>
      </li>";
    }
    print CLHTML replace_all("{PACKAGE_NAME}", $packageName, $miscFooter);
    close(CLHTML);
  }
  print DEPHTML replace_all("{PACKAGE_NAME}", $packageName, $depictionFooterAddon);
  print DEPHTML replace_all("{PACKAGE_NAME}", $packageName, $miscFooter);
  print PKGHTML "<li><a href=\"" . $depictionFolder. "\" role=\"button\">" . $packageName . "<br><small>Version " . $packageVersion . " &middot; " . $packageID . "</small></a></li>\n";
  close(DEPHTML);
  open (my $outReleases, '>>', "Packages.tmp") || die $!;
  if (open(my $fh, '<', "Packages")) {
    while (my $row = <$fh>) {
      chomp $row;
      print $outReleases "$row\n";
      if(index($row, $packageID) != -1 && index($row, "Package:") != -1) {
        print $outReleases "Depiction: $repoURL/$depictionFolder\n";
        if (-e $iconFilename) {
          print $outReleases "Icon: $repoURL/$iconFilename\n";
        }
      }
    }
    close($fh);
  }
  close($outReleases);
  rename("Packages.tmp", "Packages");
}
print PKGHTML replace_all("{PACKAGE_NAME}", $packageName, "</ul>" . $miscFooter);
closedir(DEB_Dir);
close(PKGHTML);

print RLS $output;
close(RLS);

# bzip2 packages to a new file
system("bzip2 -fks Packages");

system("find . -name ‘*.DS_Store’ -type f -delete");

system("git add . && git commit -m 'Update repo - automated' && git push");

exit 0;
