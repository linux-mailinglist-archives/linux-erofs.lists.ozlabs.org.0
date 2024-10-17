Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 057DE9A1BE1
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Oct 2024 09:44:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XTfwr67FLz3bbn
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Oct 2024 18:44:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729151051;
	cv=none; b=jeBifQLFfp1zEVGpuUMJm6D83/b02+dtOCkUwHi39IY7CYZut0u68odhWdG3lEg8MoQh3/zw8sCMRanzXuGBiJGSF9uVvbEYeyJ3Rb9F4nATDn85Ya2f7UIhNovgNmIIlypCQ7Q9fh73j9/YbVb7Of0yLPuIP0b4uQD7zZIZ5IRQLzdysxPjQnmn4FoWPq7+K/CX+tSvmSVvGHp2oiXlTaxYWp+dtNknW3Zkxruoheir7LmRhNjeq0QKG+p62pp0+DWvm0YsFJObJANbrY8ouSrd9IXjkJ8iX5KYO/IPL2b8oktmcRMnKMNjTCVo7O1m30gq8X51RBiUaPvpgb3XBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729151051; c=relaxed/relaxed;
	bh=XhT6uxKP9Uae+hLZ9BtprRmoqKINvKXGmZwujbe2LRc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KpgRipTfj0coGjPbg/3OXaiWPzGI47awSLE7bNOtQKOQcUdervDLYL3GDEtY/5xEnNN+knb3IQJox1uYvuycHG7OxgSFB15kxbvJWl8+mqEN+60j4Qc+kDbrwi09bvdzGaUIVYQ4qYhWBBb4hKY6RpK+iYKZiwPqKxUmR9/kXrJX3P/ctfCr/WdtzlCWTu4mpO+yHLnyUdSCoYTqryH0C+ImoybYtJxXJXT7/fOhXguZZ9oTxl+2ASBju6K9iUEn6aNfVizsOz4eZTxLGVECZWUbajvKZYs56RCJoFlGlNi3SyHCmo/spCUlMPLY24ahmaTQMDjLqXLvFDOsw1CErQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fYijWjbu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=21cnbao@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fYijWjbu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=21cnbao@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XTfwn11VPz2x9c
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Oct 2024 18:44:08 +1100 (AEDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-71e49ef3b2bso460309b3a.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 17 Oct 2024 00:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729151045; x=1729755845; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XhT6uxKP9Uae+hLZ9BtprRmoqKINvKXGmZwujbe2LRc=;
        b=fYijWjbuXCVjtSFF4tAykgy13ZYvXpjRlsIQ6sfjqML2StX9FF4WjcdQaNt4+K713U
         um0BHWYoHnH+zUy8yAXBw3LWDD+EN1HfvK7QSKpQ+1a+PYcT99fGmf5aFEXB8Yn+rA+V
         2n0SYvM/FZBWzr7b/aDASzhowkjWaGXMOYQK0xk79fReNqrrtsz0wu25Kha/NsOb0rp6
         AYGJaA15BCHEC6AtQUi7QQ9McZh90EMjP82fRxyKvmLAUJ+687EJQWinxQJR2cxKmKTT
         jNw6Et/Vej9vP8OCNp00H4EzjbzIE0Uyhv5cPXpcgnQ4hqlFru9JJxNjbbPQbPnoLgxc
         cCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729151045; x=1729755845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XhT6uxKP9Uae+hLZ9BtprRmoqKINvKXGmZwujbe2LRc=;
        b=AZseLf1PbXVhiFzY7AXqkyLP8Sp4898sGDZPz5uJn9q8dg0tQPJ9TXXCk77EP5tC6A
         Z/xzFNUg6m60FV/vEwrnmmH4VCOxHHDlGW9BifqqtVhcmbDS13auDxmEjCwS4N96NtZY
         tFGsgWpRewqsjtR4nlIzC4m/Ayf5X5Ogai1rcrwJG/LI/v52FRDWhNIADdPgCWPcGHck
         hshg1Ei3VfopxxBVKFSEy7WBofhMUr/F3MHoXQs5WbxU6OEUCuZ2AWktdX4guCroxkG6
         oZU4QO0QTgsKfe/PxPUU6eIH7xaMOGx+JhxIIp34XjUWiQqfRf/QZqXF2Ivyp8iTNehT
         sePg==
X-Forwarded-Encrypted: i=1; AJvYcCXZtJaf2v7GB9eeU7RxORdubhkCpTTetB69/7/aQeoY+gqLj3rIr5ls+VhaYf/b6KUUQby/z3oVlOF9bQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyyuwPbeAl5cTw0hRg1d8P4fEwXSTefs5eacn645JFh8HaW4kh4
	c09P18FtA+KiLKlN+Rfbw/68rZkZmDQjRay2hZgB9RLhViHGoZhU
X-Google-Smtp-Source: AGHT+IHeoK+fdmwnCvRuEF5gFuBt4IZPo4cdR0NzysiFxpQdaMBkJiTW+YU5+JLubqS0oIucWGhNOg==
X-Received: by 2002:a05:6a00:1892:b0:71e:7636:3323 with SMTP id d2e1a72fcca58-71e76363525mr13079868b3a.7.1729151045116;
        Thu, 17 Oct 2024 00:44:05 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:e8b7:1946:b2b3:ca4a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77371186sm4168695b3a.35.2024.10.17.00.44.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Oct 2024 00:44:04 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH RFC] fs: erofs: support PG_mappedtodisk flag for folios with zero-filled
Date: Thu, 17 Oct 2024 20:43:46 +1300
Message-Id: <20241017074346.35284-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Barry Song <v-songbaohua@oppo.com>, huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Barry Song <v-songbaohua@oppo.com>

When a folio has never been zero-filled, mark it as mappedtodisk
to allow other software components to recognize and utilize the
flag.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 fs/erofs/fileio.c | 2 ++
 fs/erofs/zdata.c  | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 3af96b1e2c2a..aa4cb438ea95 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -88,6 +88,7 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
 	struct erofs_map_blocks *map = &io->map;
 	unsigned int cur = 0, end = folio_size(folio), len, attached = 0;
 	loff_t pos = folio_pos(folio), ofs;
+	bool fully_mapped = true;
 	struct iov_iter iter;
 	struct bio_vec bv;
 	int err = 0;
@@ -124,6 +125,7 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
 			erofs_put_metabuf(&buf);
 		} else if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 			folio_zero_segment(folio, cur, cur + len);
+			fully_mapped = false;
 			attached = 0;
 		} else {
 			if (io->rq && (map->m_pa + ofs != io->dev.m_pa ||
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 8936790618c6..0158de4f3d95 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -926,7 +926,7 @@ static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *f,
 	const loff_t offset = folio_pos(folio);
 	const unsigned int bs = i_blocksize(inode);
 	unsigned int end = folio_size(folio), split = 0, cur, pgs;
-	bool tight, excl;
+	bool tight, excl, fully_mapped = true;
 	int err = 0;
 
 	tight = (bs == PAGE_SIZE);
@@ -949,6 +949,7 @@ static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *f,
 
 		if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 			folio_zero_segment(folio, cur, end);
+			fully_mapped = false;
 			tight = false;
 		} else if (map->m_flags & EROFS_MAP_FRAGMENT) {
 			erofs_off_t fpos = offset + cur - map->m_la;
@@ -1009,6 +1010,9 @@ static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *f,
 			tight = (bs == PAGE_SIZE);
 		}
 	} while ((end = cur) > 0);
+
+	if (fully_mapped)
+		folio_set_mappedtodisk(folio);
 	erofs_onlinefolio_end(folio, err);
 	return err;
 }
-- 
2.39.3 (Apple Git-146)

