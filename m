Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CAD995E2C
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Oct 2024 05:32:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XNdjq0rTVz3bjg
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Oct 2024 14:32:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728444732;
	cv=none; b=Z1Qxg3g67oMzraywvD1wbYORP1tCs/WBZnLx5usSzLaZVoWCcgJ+gwe6cV5tHvQIPDXsK1EAjmqQ04vRfOPuO5nysVxj3RbEmtopofIUILJOq1kxepi6ENnPIUXGgyHXvxmnDt10jIYHZXxSV8SYhXt0dzC+odSBVQrxRZP3JEH+gBJqHEnEAfGKgCo60BiUFZiAO0xAGwpgtK5XdmRSDX0RSUXlp4u0WmHECAMnYNNqplHCHjHPDCPZRCs+NLObzLRjOaxGpz5B2T8TEtFTFw9gsOR29N6lF9zDE0n729J9Ub7g9IG5qfJ5DemwNgI87MOiI6nyOyYEdUDsS6wdLw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728444732; c=relaxed/relaxed;
	bh=jJSUlb11QHSKUmhauCeDGT4NZMMv9jLK3BJgLEkB/1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpX6q0DtHWzNyRP/s39kRXvIAKqxECqIlN7LSVqKLfJ6SO6J7I0fn0pa8OkKKTtQJfQCxVdRUpmUFS7IfSd5PStJMQaWYpIPRbeuyHKvEw6ssT0G9h5kEeLZIOcMIu2/gP+nTYd4rj6SMqkGCoeqySZH4fjT1z3oFQGHPmCxlW7idZvXWtIgBfeCvlyiiZtVccsrOXdxvIZIP33KfIr0KZjwqgSjIIScjLViovzMiDT83ETJCTI7CSuNaER2x9fa7EcdUMe1R+4Y6Z0eMX8owVljkksmaDRKG0GQEQvZW4W2T6nNmymSy354iIWWm2eZPtXiLXCAgKr2Un8p0z4V0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UMrHoXwB; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UMrHoXwB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XNdjg4918z2yG9
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Oct 2024 14:32:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728444722; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jJSUlb11QHSKUmhauCeDGT4NZMMv9jLK3BJgLEkB/1Q=;
	b=UMrHoXwB9jl5oMZJdLDsEQ7mvBksx/G5PdYgd3nO26KqJLuvwdA+xDiYrdzn61PSNQVHl9Wm5DV8CvyvMr6vqZbg+M6DBC2e5C9jc1FkNoUue06quhpvMdJfebdDGIEoqOKCS5FKtyuoWWS6Ih3lvkR3ciGj/gJlNxCYAd4iNqw=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGhJfuR_1728444719)
          by smtp.aliyun-inc.com;
          Wed, 09 Oct 2024 11:32:00 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 2/2] erofs: use get_tree_bdev_flags() to avoid misleading messages
Date: Wed,  9 Oct 2024 11:31:51 +0800
Message-ID: <20241009033151.2334888-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
References: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
Cc: LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org, Allison Karlitskaya <allison.karlitskaya@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Users can pass in an arbitrary source path for the proper type of
a mount then without "Can't lookup blockdev" error message.

Reported-by: Allison Karlitskaya <allison.karlitskaya@redhat.com>
Closes: https://lore.kernel.org/r/CAOYeF9VQ8jKVmpy5Zy9DNhO6xmWSKMB-DO8yvBB0XvBE7=3Ugg@mail.gmail.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - use new get_tree_bdev_flags().

 fs/erofs/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 666873f745da..b89836a8760d 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -705,7 +705,9 @@ static int erofs_fc_get_tree(struct fs_context *fc)
 	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
 		return get_tree_nodev(fc, erofs_fc_fill_super);
 
-	ret = get_tree_bdev(fc, erofs_fc_fill_super);
+	ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
+		IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
+			GET_TREE_BDEV_QUIET_LOOKUP : 0);
 #ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
 	if (ret == -ENOTBLK) {
 		if (!fc->source)
-- 
2.43.5

