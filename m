Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F10976DBFC0
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Apr 2023 14:02:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PvW1x6CSkz3f5Y
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Apr 2023 22:02:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.a=rsa-sha256 header.s=202211 header.b=jh1dGoxl;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nabijaczleweli.xyz (client-ip=139.28.40.42; helo=tarta.nabijaczleweli.xyz; envelope-from=nabijaczleweli@nabijaczleweli.xyz; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.a=rsa-sha256 header.s=202211 header.b=jh1dGoxl;
	dkim-atps=neutral
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PvW1l36vfz3cdM
	for <linux-erofs@lists.ozlabs.org>; Sun,  9 Apr 2023 22:02:19 +1000 (AEST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 14EBD565C
	for <linux-erofs@lists.ozlabs.org>; Sun,  9 Apr 2023 13:56:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202211; t=1681041398;
	bh=5+GxUso7ojlOSEByCky38zKVYSofMnjP9RcdDdGud5I=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=jh1dGoxlVbuWW4plJIM3oKkrAl0ERk1ont25bUhscd+l1mumczPttkRi/0FmKJS2J
	 FQvZgIYfQIUcB+lq+kL05eGSdkw0m7NkZdQp6a4tIja4kr74LhWNP7acMMHHwxgOzk
	 5zljzZ1Uz+3WN40a2lL9UVUvmxjxa3sL47S4AU68FKGk2tV1MrKVrVZ9RIBeCOG0FR
	 Bjmp7VqqGlSB6eSnstpHe881rtwmCAKLP7KUoKqiYMlLEhYsgsYK6hBtKgfoOo3OQu
	 rRUWrO94ZX/lGjWjsU3G/CfjzVl2QeHuSoLgchrdb0a0f8s2/keyEMTDlGeNum2c9T
	 3IKBgfos/Y6tw==
Date: Sun, 9 Apr 2023 13:56:36 +0200
From: 	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Subject: [PATCH 3/5] erofs-utils: man: mkfs.erofs: wording/formatting touchups
Message-ID: <8490d5f3cbfdd11ee2690b3e642f7cd70ac9f582.1681041325.git.nabijaczleweli@nabijaczleweli.xyz>
References: <d80484200b3ba60127ff3b92e0c7660a2e8726bf.1681041325.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dwftpsizobnfvyko"
Content-Disposition: inline
In-Reply-To: <d80484200b3ba60127ff3b92e0c7660a2e8726bf.1681041325.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20230407
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--dwftpsizobnfvyko
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some things that gave me pause or were weirdly formatted.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 man/mkfs.erofs.1 | 100 +++++++++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 43 deletions(-)

diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 82ef138..1cfde28 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -20,25 +20,25 @@ mkfs.erofs is used to create such EROFS filesystem \fID=
ESTINATION\fR image file
 from \fISOURCE\fR directory.
 .SH OPTIONS
 .TP
-.BI "\-z " compression-algorithm " [" ",#" "]" " [:" " ... " "]"
+.BI "\-z " compression-algorithm \fR[\fP, # \fR][\fP: ... \fR]\fP
 Set a primary algorithm for data compression, which can be set with an opt=
ional
 compression level (1 to 12 for LZ4HC, 0 to 9 for LZMA and 100 to 109 for L=
ZMA
 extreme compression) separated by a comma.  Alternative algorithms could be
 specified and separated by colons.
 .TP
 .BI "\-C " max-pcluster-size
-Specify the maximum size of compress physical cluster in bytes. It may ena=
ble
-big pcluster feature if needed (Linux v5.13+).
+Specify the maximum size of compress physical cluster in bytes.
+This may cause the big pcluster feature to be enabled (Linux v5.13+).
 .TP
 .BI "\-d " #
 Specify the level of debugging messages. The default is 2, which shows bas=
ic
 warning messages.
 .TP
 .BI "\-x " #
-Specify the upper limit of an xattr which is still inlined. The default is=
 2.
-Disable storing xattrs if < 0.
+Limit how many xattrs will be inlined. The default is 2.
+Disables storing xattrs if < 0.
 .TP
-.BI "\-E " extended-option " [,...]"
+.BI "\-E " extended-option \fR[\fP, ... \fR]\fP
 Set extended options for the filesystem. Extended options are comma separa=
ted,
 and may take an extra argument using the equals ('=3D') sign.
 The following extended options are supported:
@@ -51,29 +51,30 @@ it may take an argument as the pcluster size of the pac=
ked inode in bytes.
 .TP
 .BI dedupe
 Enable global compressed data deduplication to minimize duplicated data in
-the filesystem. It may be used with \fI-Efragments\fR option together to
-further reduce image sizes. (Linux v6.1+)
+the filesystem. May further reduce image size when used with
+.BR -E\ fragments .
+(Linux v6.1+)
 .TP
 .BI force-inode-compact
-Forcely generate compact inodes (32-byte inodes) to output.
+Force generation of compact (32-byte) inodes.
 .TP
 .BI force-inode-extended
-Forcely generate extended inodes (64-byte inodes) to output.
+Force generation of extended (64-byte) inodes.
 .TP
 .BI force-inode-blockmap
-Forcely generate inode chunk format in 4-byte block address array.
+Force generation of inode chunk format as a 4-byte block address array.
 .TP
 .BI force-chunk-indexes
-Forcely generate inode chunk format in 8-byte chunk indexes (with device i=
d).
+Forcely generate inode chunk format as an 8-byte chunk index (with device =
ID).
 .TP
-.BI fragments
-Pack the tail part (pcluster) of compressed files or the whole files into a
+.BI fragments\fR[\fP=3D size \fR]\fP
+Pack the tail part (pcluster) of compressed files, or entire files, into a
 special inode for smaller image sizes, and it may take an argument as the
 pcluster size of the packed inode in bytes. (Linux v6.1+)
 .TP
 .BI legacy-compress
-Drop "inplace decompression" and "compacted indexes" support, which is used
-to generate compatible EROFS images for Linux v4.19 - 5.3.
+Disable "inplace decompression" and "compacted indexes",
+for compatibility with Linux pre-v5.4.
 .TP
 .BI noinline_data
 Don't inline regular files to enable FSDAX for these files (Linux v5.15+).
@@ -89,8 +90,8 @@ Set the volume label for the filesystem to
 The maximum length of the volume label is 16 bytes.
 .TP
 .BI "\-T " #
-Set all files to the given UNIX timestamp. Reproducible builds requires se=
tting
-all to a specific one.
+Set all files to the given UNIX timestamp. Reproducible builds require set=
ting
+all to a specific one. By default, the source file's modification time is =
used.
 .TP
 .BI "\-U " UUID
 Set the universally unique identifier (UUID) of the filesystem to
@@ -102,64 +103,77 @@ like this: "c1b9d5a2-f162-11cf-9ece-0020afc76f16".
 Make all files owned by root.
 .TP
 .BI "\-\-blobdev " file
-Specify another extra blob device to store chunk-based data.
+Specify an extra blob device to store chunk-based data.
 .TP
 .BI "\-\-chunksize " #
 Generate chunk-based files with #-byte chunks.
 .TP
 .BI "\-\-compress-hints " file
-If the optional
-.BI "\-\-compress-hints " file
-argument is given,
-.B mkfs.erofs
-uses it to apply the per-file compression strategy. Each line is defined by
+Apply a per-file compression strategy. Each line in
+.I file
+is defined by
 tokens separated by spaces in the following form.  Optionally, instead of
-the given primary algorithm, alternative algorithms could be specified with
-\fIalgorithm-index\fR by hand:
+the given primary algorithm, alternative algorithms can be specified with
+\fIalgorithm-index\fR explicitly:
 .RS 1.2i
-<pcluster-in-bytes> [algorithm-index] <match-pattern>
+<pcluster-size-in-bytes> [algorithm-index] <match-pattern>
 .RE
+.IR match-pattern s
+are extended regular expressions, matched against absolute paths within
+the output filesystem, with no leading /.
 .TP
 .BI "\-\-exclude-path=3D" path
 Ignore file that matches the exact literal path.
-You may give multiple `--exclude-path' options.
+You may give multiple
+.B --exclude-path
+options.
 .TP
 .BI "\-\-exclude-regex=3D" regex
-Ignore files that match the given regular expression.
-You may give multiple `--exclude-regex` options.
+Ignore files that match the given extended regular expression.
+You may give multiple
+.B --exclude-regex
+options.
 .TP
 .BI "\-\-file-contexts=3D" file
-Specify a \fIfile_contexts\fR file to setup / override selinux labels.
+Read SELinux label configuration/overrides from \fIfile\fR in the
+.BR selinux_file (5)
+format.
 .TP
 .BI "\-\-force-uid=3D" UID
-Set all file uids to \fIUID\fR.
+Set all file UIDs to \fIUID\fR.
 .TP
 .BI "\-\-force-gid=3D" GID
-Set all file gids to \fIGID\fR.
+Set all file GIDs to \fIGID\fR.
 .TP
 .BI "\-\-gid-offset=3D" GIDOFFSET
-Add \fIGIDOFFSET\fR to all file gids.
-When this option is used together with --force-gid, the final file gids are
+Add \fIGIDOFFSET\fR to all file GIDs.
+When this option is used together with
+.BR --force-gid ,
+the final file gids are
 set to \fIGID\fR + \fIGID-OFFSET\fR.
 .TP
 .B \-\-help
-Display this help and exit.
+Display help string and exit.
 .TP
 .B "\-\-ignore-mtime"
-File modification time is ignored whenever it would cause \fBmkfs.erofs\fR=
 to
+Ignore the file modification time whenever it would cause \fBmkfs.erofs\fR=
 to
 use extended inodes over compact inodes. When not using a fixed timestamp,=
 this
-can reduce total metadata size.
+can reduce total metadata size. Implied by
+.BR "-E force-inode-compact" .
 .TP
 .BI "\-\-max-extent-bytes " #
-Specify maximum decompressed extent size # in bytes.
+Specify maximum decompressed extent size in bytes.
 .TP
 .B "\-\-preserve-mtime"
-File modification time is preserved whenever \fBmkfs.erofs\fR decides to u=
se
-extended inodes over compact inodes.
+Use extended inodes instead of compact inodes if the file modification time
+would overflow compact inodes. This is the default. Overrides
+.BR --ignore-mtime .
 .TP
 .BI "\-\-uid-offset=3D" UIDOFFSET
-Add \fIUIDOFFSET\fR to all file uids.
-When this option is used together with --force-uid, the final file uids are
+Add \fIUIDOFFSET\fR to all file UIDs.
+When this option is used together with
+.BR --force-uid ,
+the final file uids are
 set to \fIUID\fR + \fIUIDOFFSET\fR.
 .SH AUTHOR
 This version of \fBmkfs.erofs\fR is written by Li Guifu <blucerlee@gmail.c=
om>,
--=20
2.30.2


--dwftpsizobnfvyko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmQyp/QACgkQvP0LAY0m
WPHWqw//TzRKa8BOwGCEejgeuKGd2rUQck5FqUmxaUO4AFoQG2xI+v774T7HWpNB
qQYv8Avi2u+c1J9g0ehxN8O9NKzjzlu1ieM/jzLlqK787f18Fu2uMSBBvuXI3Uzt
lcrtYeVUO5s0fLtDbjP3ac9tkbex+5ImE9tVubjEb155zK7If2VhYfN+3zC+AWiL
csYThYuqKdnNMCP0xR1IhMWMDGQQW/xXT2XkIt/rzKSI5FMZ9pntPjs8OP3uCwNy
S/jRbNtH1KyuDkJyS8NXlVr4lALXO0eSHrExZQw57X02hDBZCIFhVTJe8yLv5xf/
Ke0S3anrBwCYNQN92LuLOOL1wsgR0Pvb+sTSd5DiBn7i5uBZ4iRFKzUHH3xN8rAh
QSPm0V5Wd/dCcr3aZoCc1UpZTNz1ZcvVHwf1j3Yo5A69/4Pq8j4ZiSWU5SVbTgbf
B83ddC+WnAXKYb/LjU40ub6Fb874kLz2jOyeaDO2SveF2WRgh1rnbGdyXgKO9AeE
rruZ299uCJN5E0AkVslmKDNfxVCslcfrjwlikCVKxGcukJFL+fdf4o4Z2o/y6ZuK
r59TeC4Vz/rYIoJA0x3Wh8OnOy9CMUwOKs9TwfY5HYZGC+TovUpJKW2os6Cs3GbD
j/xkSfv+6GXQQjP8O5iK0zpD7yo3/Ez4gRPpinW+8olfe1sFCio=
=duMe
-----END PGP SIGNATURE-----

--dwftpsizobnfvyko--
