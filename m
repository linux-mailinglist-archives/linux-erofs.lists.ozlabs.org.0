Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEA7868880
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Feb 2024 06:12:27 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=mbaynton-com.20230601.gappssmtp.com header.i=@mbaynton-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=LketC54J;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TkQbF1XQhz3cVv
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Feb 2024 16:12:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=mbaynton-com.20230601.gappssmtp.com header.i=@mbaynton-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=LketC54J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=mbaynton.com (client-ip=2607:f8b0:4864:20::d30; helo=mail-io1-xd30.google.com; envelope-from=mike@mbaynton.com; receiver=lists.ozlabs.org)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TkQb51TK1z2xPY
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Feb 2024 16:12:17 +1100 (AEDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7c7b8fb8ba6so107209239f.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 26 Feb 2024 21:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbaynton-com.20230601.gappssmtp.com; s=20230601; t=1709010732; x=1709615532; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t+TWs+H0ocrFopell/NtyO89SnJPjFyUYBDG/DVdENE=;
        b=LketC54JyfllvT9OaXd9Bd98V2j9fCVHqORmQ8WoMI7/LguwxfD8S7Z3Q0DhOv02Wd
         GwuQ0CPa6dq1G8n9ePlLzoACfk0p8uIE9q6Gqhsk0CmAyhxTXxUohLGiwDd97GHv8J6F
         IBhyZTkF6Dr11njwRsPcSIof3gsbuCVxqF8c4bjTPnGdVYkmR5VHU2UuYaRjdzRS6JMY
         i9S2MHvvMAciRIRG2lv9A6NikOzCb4tH8dRZxVxlSnd6X9WRD8orO00RRorlVXBasDFk
         xxlEKJPkWrDBG2ipHIr3H65J7I3jpRYVoIbNt2qpYon+oZhGmH8JnfG8ANZ5Z4YVaqkE
         aWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709010732; x=1709615532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+TWs+H0ocrFopell/NtyO89SnJPjFyUYBDG/DVdENE=;
        b=RquZ3lwaUr2i0YwzvC1sK5aRyN1EJbHIcmrKWp7hFUIpYYdHuxqPhsyzm2WcPyA98L
         91d0RV0eTfg5bv6GpB85FyTA5WQ4NKmKhIelz3mCjgD5pzML/3PNFhytTqb8HcojdfUH
         6wAk5csPqCe8pBz+nC+MUbcBxkpIKPMVCji/fFfCgL3rqgTZ833nZjU0ib1ZhDK6hi4+
         /B7TXnCmJGjD/FR6Ag2ke688d/G34hAWQAhoiGsdiIRHBhp1Z6Xoy3YOD6jBJiWGdxBh
         vpF171ddst+e/JVBHFBqOM9DpKbJ3SBwoDga43Xg7HdLp038C5iLJVlLs/BP1wE9JMut
         lwlw==
X-Gm-Message-State: AOJu0Yx7ZWitaD27cYiHEb7vOfhgX+kbHwjjl4XUfm9IW0xmEGbszVMA
	upv+wKs2vEWySvwjcDNw2nk9qJuuHuHLRlJ1qMlZ9O3VkSaE98XhrCKr9r6z7K58kjoNnU4JkOn
	d
X-Google-Smtp-Source: AGHT+IGTRw8aHQEAdiCLi6XRG/DEKU9l0HU+Po+QtJA5etojc4nMePU5pztu676Fmy+Dxu4eq0pRKw==
X-Received: by 2002:a5e:834c:0:b0:7c7:d7fd:44d5 with SMTP id y12-20020a5e834c000000b007c7d7fd44d5mr3508929iom.12.1709010731674;
        Mon, 26 Feb 2024 21:12:11 -0800 (PST)
Received: from mike-laptop.lan.mbaynton.com ([2601:444:600:440:777a:c763:a1e5:964])
        by smtp.gmail.com with ESMTPSA id f21-20020a02b795000000b004745ef63802sm1668720jam.49.2024.02.26.21.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 21:12:11 -0800 (PST)
From: Mike Baynton <mike@mbaynton.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: Support tar source without data
Date: Mon, 26 Feb 2024 23:11:54 -0600
Message-Id: <20240227051154.4009326-1-mike@mbaynton.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This improves performance of meta-only image creation in cases where the
source is a tarball stream that is not seekable. The writer may now use
--tar=headerball and omit the file data. Previously, the stream writer was
forced to send the file's size worth of null bytes or any data after each
tar header which was simply discarded by mkfs.erofs.

Signed-off-by: Mike Baynton <mike@mbaynton.com>
---
Sorry for the delay getting to this, it fulfills a feature request
discussed a week or so ago:
<https://lore.kernel.org/linux-erofs/5db6f727-00e1-4625-9914-3ffabfc8c43f@linux.alibaba.com>
It sounded like we wanted the new option to be more verbose than just
`h`, and I thought "headerball" hinted at what it is more than "header",
but happy to change it if that's too weird!

Thank you for your careful review, it's a simple change but this was
motivated by necessity and isn't really my wheelhouse.

 include/erofs/tar.h |  2 +-
 lib/tar.c           |  2 +-
 man/mkfs.erofs.1    | 23 +++++++++++++++++------
 mkfs/main.c         |  9 ++++++---
 4 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/include/erofs/tar.h b/include/erofs/tar.h
index a76f740..3d40a0f 100644
--- a/include/erofs/tar.h
+++ b/include/erofs/tar.h
@@ -46,7 +46,7 @@ struct erofs_tarfile {
 
 	int fd;
 	u64 offset;
-	bool index_mode, aufs;
+	bool index_mode, headeronly_mode, aufs;
 };
 
 void erofs_iostream_close(struct erofs_iostream *ios);
diff --git a/lib/tar.c b/lib/tar.c
index 8204939..e916395 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -584,7 +584,7 @@ static int tarerofs_write_file_index(struct erofs_inode *inode,
 	ret = tarerofs_write_chunkes(inode, data_offset);
 	if (ret)
 		return ret;
-	if (erofs_iostream_lskip(&tar->ios, inode->i_size))
+	if (!tar->headeronly_mode && erofs_iostream_lskip(&tar->ios, inode->i_size))
 		return -EIO;
 	return 0;
 }
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 00ac2ac..d488983 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -17,7 +17,7 @@ achieve high performance for embedded devices with limited memory since it has
 unnoticable memory overhead and page cache thrashing.
 .PP
 mkfs.erofs is used to create such EROFS filesystem \fIDESTINATION\fR image file
-from \fISOURCE\fR directory.
+from \fISOURCE\fR directory or tarball.
 .SH OPTIONS
 .TP
 .BI "\-z " compression-algorithm \fR[\fP, # \fR][\fP: ... \fR]\fP
@@ -180,11 +180,22 @@ Use extended inodes instead of compact inodes if the file modification time
 would overflow compact inodes. This is the default. Overrides
 .BR --ignore-mtime .
 .TP
-.B "\-\-tar=f"
-Generate a full EROFS image from a tarball.
-.TP
-.B "\-\-tar=i"
-Generate an meta-only EROFS image from a tarball.
+.BI "\-\-tar, \-\-tar="MODE
+Treat \fISOURCE\fR as a tarball or tarball-like "headerball" rather than as a
+directory.
+
+\fIMODE\fR may be one of \fBf\fR, \fBi\fR, or \fBheaderball\fR.
+
+\fBf\fR: Generate a full EROFS image from a regular tarball. (default)
+
+\fBi\fR: Generate a meta-only EROFS image from a regular tarball. Only
+metadata such as dentries, inodes, and xattrs will be added to the image,
+without file data. Uses for such images include as a layer in an overlay
+filesystem with other data-only layers.
+
+\fBheaderball\fR: Generate a meta-only EROFS image from a stream identical
+to a tarball except that file data is not present after each file header.
+Can improve performance especially when \fISOURCE\fR is not seekable.
 .TP
 .BI "\-\-uid-offset=" UIDOFFSET
 Add \fIUIDOFFSET\fR to all file UIDs.
diff --git a/mkfs/main.c b/mkfs/main.c
index 6d2b700..36e248a 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -122,7 +122,8 @@ static void usage(void)
 	      " --max-extent-bytes=#  set maximum decompressed extent size # in bytes\n"
 	      " --preserve-mtime      keep per-file modification time strictly\n"
 	      " --aufs                replace aufs special files with overlayfs metadata\n"
-	      " --tar=[fi]            generate an image from tarball(s)\n"
+	      " --tar=[X]             generate a full or index-only image from a tarball(-ish) source\n"
+	      "                       X=f|i|headerball; f=full, i=index, headerball=tar w/o file data\n"
 	      " --ovlfs-strip=[01]    strip overlayfs metadata in the target image (e.g. whiteouts)\n"
 	      " --quiet               quiet execution (do not write anything to standard output.)\n"
 #ifndef NDEBUG
@@ -514,11 +515,13 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			cfg.c_extra_ea_name_prefixes = true;
 			break;
 		case 20:
-			if (optarg && (!strcmp(optarg, "i") ||
-				!strcmp(optarg, "0") || !memcmp(optarg, "0,", 2))) {
+			if (optarg && (!strcmp(optarg, "i") || (!strcmp(optarg, "headerball") ||
+				!strcmp(optarg, "0") || !memcmp(optarg, "0,", 2)))) {
 				erofstar.index_mode = true;
 				if (!memcmp(optarg, "0,", 2))
 					erofstar.mapfile = strdup(optarg + 2);
+				if (!strcmp(optarg, "headerball"))
+					erofstar.headeronly_mode = true;
 			}
 			tar_mode = true;
 			break;
-- 
2.34.1

