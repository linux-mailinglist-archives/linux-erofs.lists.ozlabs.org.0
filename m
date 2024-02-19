Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FC7859B06
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Feb 2024 04:37:28 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=mbaynton-com.20230601.gappssmtp.com header.i=@mbaynton-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=0ufsF7rP;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TdSsK70Rbz3cCx
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Feb 2024 14:37:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=mbaynton-com.20230601.gappssmtp.com header.i=@mbaynton-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=0ufsF7rP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=mbaynton.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=mike@mbaynton.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TdSsF4JZMz2ykx
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Feb 2024 14:37:20 +1100 (AEDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6e34d12404eso945044b3a.2
        for <linux-erofs@lists.ozlabs.org>; Sun, 18 Feb 2024 19:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbaynton-com.20230601.gappssmtp.com; s=20230601; t=1708313837; x=1708918637; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p3KmrllB5yaEwVe6GoXrTTdQM7kF/0Y+jfB4pLL67F4=;
        b=0ufsF7rPbt850oiQn765nOi/78xjC/npQVqBGTyVZ+MFwIdXsOH7VazMybyW60L9VU
         2rQZ6ESfPN/zkuGk7DeOy6zeGJIQQx7OWJH5up5JkKazNz+SJ+Su7rLVzcqr8err81A8
         v+SbhH1Al0uun4DGShrzPVyuT0xkuN9vIL62V14N2kYjnblyw5HV0ZSUqIt6TMIc2DfM
         FvRUkwi/eZJ8we7oy6KBwDViTFTIMGzMJ6wwu+Syw3JgXlEAa1Pa6HNhwiw4isgbJtv0
         /SMCXm34vgek7PBIxVDl8YPvtPhoVi/a0Wp+cnKEoIE6+nOTRL5FpRys7AcbLJvqE3Uq
         8i+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708313837; x=1708918637;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p3KmrllB5yaEwVe6GoXrTTdQM7kF/0Y+jfB4pLL67F4=;
        b=DVLl2VlbCrJZqN8KxN9Xt3pXpcW9QbtyT3EnjNlm5a5gtLpp2Iwjx6dHXJqA3UQ2vR
         vGP3fhbugGA8ZuHo+hR0WqR3hplO1s5d6dvVQuKnT4fBRbKuYrYxMiLQYPjBl6Z3ZLoP
         VOd8lpcITXYqH4LeQFjKHMMFZLmcPPEJ5TwQOUeJe2mz7Y+1+3v+ZcxWK5kpZ+X7Pi2h
         DvMGqWxpDYvDh4zrek0VuppPMpG3awj/R0O0a3j+vO/i0wsZD2ZQ4HUNf/is7fJgu+yh
         cT8tw81/W41m0XJxm0sSoL20eZQOT43K6VZMsEDOvSfPWRZekEybMgNNUQ7zz7JbSsOX
         yHsw==
X-Gm-Message-State: AOJu0YzZyj8vA/gcxJ63RctD2Z81TQjOgjMwOWNXhEkRWYUSpAX2cZRY
	07nhNaHQWwO6wGSd1wDJunZuhgVUZtz1Bu5CXEiwxpxErZ6vPtAqNXYq708MyoBwn8J+UGfax31
	mVSCKcKFxugHhFZ+Hn1Rx5Qm40+gSMqxiIP14QVbgLTQo5oP/doY=
X-Google-Smtp-Source: AGHT+IHft3nCisd9g0F+S6Jo8jzcKlRVo2ZgeV+y3GrnCDnFHtpiqsx1fKvc3/1id3cb6fmkIzy6FDb0Y0qaEgywlx4=
X-Received: by 2002:a05:6a20:9f97:b0:19e:aaec:833a with SMTP id
 mm23-20020a056a209f9700b0019eaaec833amr13229378pzb.55.1708313837250; Sun, 18
 Feb 2024 19:37:17 -0800 (PST)
MIME-Version: 1.0
From: Mike Baynton <mike@mbaynton.com>
Date: Sun, 18 Feb 2024 21:37:06 -0600
Message-ID: <CAM56kJTupW_WZapYM6YzFLPtriYb5+FU-Y8-mYY8ETGYfQmG6g@mail.gmail.com>
Subject: Feature request: erofs-utils mkfs: Efficient way to pipe only file metadata
To: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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

Hello erofs developers,
I am integrating erofs with overlayfs in a manner similar to what
composefs is doing. So, I am interested in making erofs images
containing only file metadata and extended attributes, but no file
data, as in $ mkfs.erofs --tar=i (thanks for that!)

However, I would like to construct the erofs image from a set of files
selected dynamically by another program. This leads me to prefer
sending an unseekable stream to mkfs.erofs so that file selection and
image generation can run concurrently, instead of first making a
complete tarball and then making the erofs image. In this case, it
becomes necessary to transfer each file's worth of data through the
stream after each header only so that the tarball reader in tar.c does
not become desynchronized with the expected offset of the next tar
header.

A very straightforward solution that seems to be working just fine for
me is to simply introduce a new optarg for --tar that indicates the
input data will be simply a series of tar headers / metadata without
actual file data. This implies index mode and additionally prevents
the skipping of inode.size worth of bytes after each header:

diff --git a/include/erofs/tar.h b/include/erofs/tar.h
index a76f740..3d40a0f 100644
--- a/include/erofs/tar.h
+++ b/include/erofs/tar.h
@@ -46,7 +46,7 @@ struct erofs_tarfile {

  int fd;
  u64 offset;
- bool index_mode, aufs;
+ bool index_mode, headeronly_mode, aufs;
 };

 void erofs_iostream_close(struct erofs_iostream *ios);
diff --git a/lib/tar.c b/lib/tar.c
index 8204939..e916395 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -584,7 +584,7 @@ static int tarerofs_write_file_index(struct
erofs_inode *inode,
  ret = tarerofs_write_chunkes(inode, data_offset);
  if (ret)
  return ret;
- if (erofs_iostream_lskip(&tar->ios, inode->i_size))
+ if (!tar->headeronly_mode && erofs_iostream_lskip(&tar->ios, inode->i_size))
  return -EIO;
  return 0;
 }
diff --git a/mkfs/main.c b/mkfs/main.c
index 6d2b700..a72d30e 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -122,7 +122,7 @@ static void usage(void)
        " --max-extent-bytes=#  set maximum decompressed extent size #
in bytes\n"
        " --preserve-mtime      keep per-file modification time strictly\n"
        " --aufs                replace aufs special files with
overlayfs metadata\n"
-       " --tar=[fi]            generate an image from tarball(s)\n"
+       " --tar=[fih]           generate an image from tarball(s) or
tarball header data\n"
        " --ovlfs-strip=[01]    strip overlayfs metadata in the target
image (e.g. whiteouts)\n"
        " --quiet               quiet execution (do not write anything
to standard output.)\n"
 #ifndef NDEBUG
@@ -514,11 +514,13 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
  cfg.c_extra_ea_name_prefixes = true;
  break;
  case 20:
- if (optarg && (!strcmp(optarg, "i") ||
- !strcmp(optarg, "0") || !memcmp(optarg, "0,", 2))) {
+ if (optarg && (!strcmp(optarg, "i") || (!strcmp(optarg, "h") ||
+ !strcmp(optarg, "0") || !memcmp(optarg, "0,", 2)))) {
  erofstar.index_mode = true;
  if (!memcmp(optarg, "0,", 2))
  erofstar.mapfile = strdup(optarg + 2);
+ if (!strcmp(optarg, "h"))
+ erofstar.headeronly_mode = true;
  }
  tar_mode = true;
  break;

Using this requires generation of tarball-ish streams that can be
slightly difficult to cajole tar libraries into creating, but it does
work if you do it. I can imagine much more complex alternative ways to
do this too, such as supporting sparse tar files or supporting some
whole new input format.

Would some version of this feature be interesting and useful? If so,
is the simple way good enough? It wouldn't preclude future addition of
things like a sparse tar reader.

Regards,
Mike
