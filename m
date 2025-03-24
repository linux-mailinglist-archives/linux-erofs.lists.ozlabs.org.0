Return-Path: <linux-erofs+bounces-120-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C61BA6D311
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Mar 2025 03:30:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZLcTL5VCtz2yKr;
	Mon, 24 Mar 2025 13:29:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742783398;
	cv=none; b=REUSisoiNnUIjOVfvxjRu97g5VpovNAKieCVWQylW5vsLMYTRIPqLHn42gFo87l52p68AgrBU0TnlKuK7EU7vzLyooRCp4ZNIGT0no82tdwoNZNCCi5mVbh/5CW/32wYnnTsymqkRF6M3iCzHa4jr7uYwcJO8OjUyf3H9i1j35fskAA/WhmsqZjTrAIGkamLK1FvK+9piQB17+k/NTNDXEuiHFXnSsUbBD5Iaz/lRbI2qcpauUYkwL5/pKqEaOxwVDFpCWXn2NKsqQNG0MKNR1eiLLvkD5FXhHHiBxzuXUYV5v23o/27SzcH/8T3u7AhYKTPazvIishOLiehLgUPiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742783398; c=relaxed/relaxed;
	bh=yaM6n2XXYLmZ8n5d/I+4nSqBl3pbvcVcH3xid2ni5xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kXl3j2nqqBlbDuo24ey2rtMLRWoD4bO+dx9m4wv8MSwBjiDTEilrWJztWbNdy0d3lMepUK37T77HpPvvydNK1lnBWB87h+bTQkXZaMI1PYqzmmuVEDgDz1TgkgcwlF1PUqMU8/yVdnnz3pDxX/bxMxKmB5Vcj02rN+GS8SYZygxBLwdxIIFpg/Uc6Rr+twwCHUp6sC2bn4kOhkeZEQ1pyJtX8mZr9rZxR8ka1veMXwt+0XolySxtnFXgVBKKlyIgb0BrTZuDe68XH9+r9Z5L2UqJQt82RwfCb0rferKNGCwjR71/6jwyoCE4sLKrog+eCs9Ag2pMneg1xeDHFgMmVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dhckdBfK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dhckdBfK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZLcTK2Gt3z2xlL
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Mar 2025 13:29:56 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2ff69365e1dso5117492a91.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 23 Mar 2025 19:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742783393; x=1743388193; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yaM6n2XXYLmZ8n5d/I+4nSqBl3pbvcVcH3xid2ni5xk=;
        b=dhckdBfK2VBFrCsQCokaoIGajHKbVCvcKehe6E71B/ZB8fUAJIjyRUmqckW7DzLR1/
         g/nsyl82NrkYiE+ZV4fRY3d8wG3Yw0kG/eJfbHLQMHiIiYsyr+KE9jzwcVnRsW6hgDfB
         yJYdxRZ6kPvHHye7ciD+dDU2ku5Nal1VZwixaS6PLevKTvGGQE6ozjZAOrVLXLUdwwJb
         C43KFzDT9PoX0q4wOmzSXecGcT4w+VzmPOh7m3+UJCh/Zjrt6r+Av7tKzVKM1IwpyWG2
         9n8X98Va8jMTWUYrYOsqX1G7sJ680fylSMJFCsYWuVr0Zc5mFN7vFt+HKUd++fjCYfzS
         D7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742783393; x=1743388193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yaM6n2XXYLmZ8n5d/I+4nSqBl3pbvcVcH3xid2ni5xk=;
        b=HyzJplMR9DmyaeIReFi+AQZv0qpDmSlo4zGh2MyuMUyom3wjdt7TK4ollQl6uQRD5O
         QmvoDNgza2jprr6L+hEucYF//YhmTLz0P9aeq2G4nRQ1dN93Co9oKKb0QjnWm0czt9jC
         JSd7wnTtVl6fQIACgJy78ZWNlgTUOq1rZBJFWtiw4ed1zcBkMaOcHqvNta3T9d7TQpAp
         rxLHIWocvuVMT6CZ4+aOIPUcIhX+kckKUFx5VCs0sx577vxzPBj7uQDliVq+psIru5Qd
         TgPDDeVg25v71JNa5ivMi/P00ktpDfZy69e/ITpYyAX3L9vKxrRy9hDf1UJpmfuhmgp7
         jLvA==
X-Forwarded-Encrypted: i=1; AJvYcCUmwQE68HGRbwO/+jgmn9Lux0Om0ZPZvDfJkDP3pZZB4HP2y6DmzWWMBjULYGyEjeEYe6s5SEZaofCD8w==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YygQxXHja/6lNF1fLcmESzTOpaosluCRbgstTDdORNXO0jJ6dLx
	x3fzQRh44YyviLQSIAUSkngHfDSXFvCuM2+I+CiD/vxM7acIW0rchpZ95WhHC60=
X-Gm-Gg: ASbGncuuuJxlaLSqXjey+ubpewBDj5uza7W1JFiIBZgV8LNBOQUsE3gDVLc3CBSCBqa
	DaadEzAT7bf+tKJozGSxb1XZIY1JxZ+9+jQJci+UGZSdIjnehl7Y7v+r5633ResUPURMXR3XWXq
	NQ2NUZfot5IHSBFn4dcp6q7hvvwWxJlsk5SpJ5WDHssx1neQaKH0p2wJoTWMhTkuTVmrfCvpF4b
	F8jdzUefXwR37dRMZjYeI+D7gRsCC2W1my4fGytFE8YmigcjZiKou50tcYmIcgh08JvlAOkh+X6
	t5dfMn9yXGBQD+OtDdUzeOREFtQNkKdJLHoXKeGB+ehvqAz2038=
X-Google-Smtp-Source: AGHT+IEAXpsiG5tbfaOZ8P/dnIoqp2v4G8Rmy4yiyC0YGAtvYj/KSf22X/DmKW0gENF2r0rPNv2AAQ==
X-Received: by 2002:a17:90b:1d51:b0:2ee:e518:c1d8 with SMTP id 98e67ed59e1d1-3030ff046d7mr17532828a91.30.1742783393114;
        Sun, 23 Mar 2025 19:29:53 -0700 (PDT)
Received: from PC.mioffice.cn ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3030f807037sm6735538a91.41.2025.03.23.19.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 19:29:52 -0700 (PDT)
From: Sheng Yong <shengyong2021@gmail.com>
X-Google-Original-From: Sheng Yong <shengyong1@xiaomi.com>
To: xiang@kernel.org,
	chao@kernel.org,
	zbestahu@gmail.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com,
	linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	Sheng Yong <shengyong1@xiaomi.com>,
	Wang Shuai <wangshuai12@xiaomi.com>
Subject: [RFC PATCH] erofs: add start offset for file-backed mount
Date: Mon, 24 Mar 2025 10:28:49 +0800
Message-ID: <20250324022849.2715578-1-shengyong1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Sheng Yong <shengyong1@xiaomi.com>

When attempting to use an archive file, such as APEX on android,
as a file-backed mount source, it fails because EROFS image within
the archive file does not start at offset 0. As a result, a loop
device is still needed to attach the image file at an appropriate
offset first.

To address this issue, this patch parses the `source' parameter in
EROFS to accept a start offset for the file-backed mount. The format
is `/path/to/archive_file:offs', where `offs' represents the start
offset. EROFS will add this offset before performing read requests.

Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
Signed-off-by: Wang Shuai <wangshuai12@xiaomi.com>
---
 fs/erofs/data.c     |  7 ++++++-
 fs/erofs/fileio.c   |  8 ++++++--
 fs/erofs/internal.h |  2 ++
 fs/erofs/super.c    | 37 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 2409d2ab0c28..957743201ef5 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -27,9 +27,12 @@ void erofs_put_metabuf(struct erofs_buf *buf)
 
 void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
 {
-	pgoff_t index = offset >> PAGE_SHIFT;
+	pgoff_t index;
 	struct folio *folio = NULL;
 
+	offset += buf->fofs;
+	index = offset >> PAGE_SHIFT;
+
 	if (buf->page) {
 		folio = page_folio(buf->page);
 		if (folio_file_page(folio, index) != buf->page)
@@ -54,9 +57,11 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
 	buf->file = NULL;
+	buf->fofs = 0;
 	if (erofs_is_fileio_mode(sbi)) {
 		buf->file = sbi->dif0.file;	/* some fs like FUSE needs it */
 		buf->mapping = buf->file->f_mapping;
+		buf->fofs = sbi->dif0.fofs;
 	} else if (erofs_is_fscache_mode(sb))
 		buf->mapping = sbi->dif0.fscache->inode->i_mapping;
 	else
diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index bec4b56b3826..62288ef19920 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -45,15 +45,19 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 
 static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
 {
+	struct erofs_sb_info *sbi;
 	struct iov_iter iter;
 	int ret;
 
 	if (!rq)
 		return;
-	rq->iocb.ki_pos = rq->bio.bi_iter.bi_sector << SECTOR_SHIFT;
+
+	sbi = EROFS_SB(rq->sb);
+	rq->iocb.ki_pos = sbi->dif0.fofs +
+				(rq->bio.bi_iter.bi_sector << SECTOR_SHIFT);
 	rq->iocb.ki_ioprio = get_current_ioprio();
 	rq->iocb.ki_complete = erofs_fileio_ki_complete;
-	if (test_opt(&EROFS_SB(rq->sb)->opt, DIRECT_IO) &&
+	if (test_opt(&sbi->opt, DIRECT_IO) &&
 	    rq->iocb.ki_filp->f_mode & FMODE_CAN_ODIRECT)
 		rq->iocb.ki_flags = IOCB_DIRECT;
 	iov_iter_bvec(&iter, ITER_DEST, rq->bvecs, rq->bio.bi_vcnt,
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4ac188d5d894..b0a752b955f6 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -43,6 +43,7 @@ struct erofs_device_info {
 	char *path;
 	struct erofs_fscache *fscache;
 	struct file *file;
+	loff_t fofs;
 	struct dax_device *dax_dev;
 	u64 dax_part_off;
 
@@ -199,6 +200,7 @@ enum {
 struct erofs_buf {
 	struct address_space *mapping;
 	struct file *file;
+	loff_t fofs;
 	struct page *page;
 	void *base;
 };
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index cadec6b1b554..87ddeb327a8a 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -356,7 +356,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
 
 enum {
 	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
-	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio,
+	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio, Opt_source,
 	Opt_err
 };
 
@@ -384,6 +384,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 	fsparam_string("fsid",		Opt_fsid),
 	fsparam_string("domain_id",	Opt_domain_id),
 	fsparam_flag_no("directio",	Opt_directio),
+	fsparam_string("source",	Opt_source),
 	{}
 };
 
@@ -411,6 +412,31 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
 #endif
 }
 
+static loff_t erofs_fc_parse_source(struct fs_context *fc,
+				    struct fs_parameter *param)
+{
+	const char *devname = param->string;
+	const char *fofs_start __maybe_unused;
+	loff_t fofs = 0;
+
+	if (!devname || !*devname)
+		return invalfc(fc, "Empty source");
+
+#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
+	fofs_start = strchr(devname, ':');
+	if (!fofs_start)
+		goto out;
+	if (kstrtoll(fofs_start + 1, 0, &fofs) < 0)
+		return invalfc(fc, "Invalid filebacked offset %s", fofs_start);
+	fc->source = kstrndup(devname, fofs_start - devname, GFP_KERNEL);
+	return fofs;
+out:
+#endif
+	fc->source = devname;
+	param->string = NULL;
+	return fofs;
+}
+
 static int erofs_fc_parse_param(struct fs_context *fc,
 				struct fs_parameter *param)
 {
@@ -507,6 +533,11 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
 #endif
 		break;
+	case Opt_source:
+		sbi->dif0.fofs = erofs_fc_parse_source(fc, param);
+		if (sbi->dif0.fofs < 0)
+			return -EINVAL;
+		break;
 	}
 	return 0;
 }
@@ -697,6 +728,10 @@ static int erofs_fc_get_tree(struct fs_context *fc)
 		file = filp_open(fc->source, O_RDONLY | O_LARGEFILE, 0);
 		if (IS_ERR(file))
 			return PTR_ERR(file);
+		if (sbi->dif0.fofs + PAGE_SIZE >= i_size_read(file_inode(file))) {
+			fput(file);
+			return invalf(fc, "Start offset too large");
+		}
 		sbi->dif0.file = file;
 
 		if (S_ISREG(file_inode(sbi->dif0.file)->i_mode) &&
-- 
2.43.0


