Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8D1D4649
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Oct 2019 19:10:52 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46qZGd20TfzDqcD
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Oct 2019 04:10:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com;
 envelope-from=blucerlee@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="RFE+eeWx"; 
 dkim-atps=neutral
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46qZGX1qpXzDqZG
 for <linux-erofs@lists.ozlabs.org>; Sat, 12 Oct 2019 04:10:44 +1100 (AEDT)
Received: by mail-pf1-x434.google.com with SMTP id y22so6459449pfr.3
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Oct 2019 10:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9n1393IKDhZoLLXC//1IoQmIqEo1TG2KclICqHPDHVY=;
 b=RFE+eeWxUwq17OFtXwBC49n0ST/KE6XW5BbdVe1ggb3JS4xl0OP+nbvfU77Zygl6h/
 Zl6DgUczOYm0oMtQdnICvMeI6YPm6A1CkVx9GQELrYrDzVxn8HoUVJJOTiDibFCRFNWo
 ywPMj2dQnzbQ/6ZqeDdp8LhHnoD6Yq1QMR9hGkuPBh+CVc5XwQrZILdgSbgeeEalg8KE
 S3u5AXpyF0HyHjg1kguBAVkTM5EkxS5qfW+/6HzJ5SpsjBn7a9XaBSIqaxFfCd1XI4NR
 ng2+Y6m6rykWX7fOd3qcbLdT5ZCSomvQd53BA/lZUi2a7FzMNK3HVwHvOo6g/slwcOmi
 O12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9n1393IKDhZoLLXC//1IoQmIqEo1TG2KclICqHPDHVY=;
 b=WRCGYX9MZAg9zZLIGf1bszs3AmeWJx23+po3oXbplxCC0FiiaDoMV9ENHJ+dF3f9JD
 xFbE6kBodLlnKg7sqfx/BGLlyzfBCXiZe5Tun9fjG5jKcwfuUSsDGcErCrxLk6QZKftZ
 6McvAr11RKEXZEn9DvdhPY72QzrVhjq1RB+eDDTR/JgFbfp/cte4DWMCpxTnL194C77+
 k5KN+8u+nxycLrGLYEy9d5yVnThTsfZBMe0RDPV2a3oLuX9FfFD4GSFKANZG7uMYHnTC
 2mqJt+keQYqGA7CuM7bfhR3fqAVVjL9iTutgFZGW0RmzwzPpHFz6GBhwnx9mmXJ7y4hO
 v3bQ==
X-Gm-Message-State: APjAAAWSZSbcM9/9sShjnjSTsyLQugvNc+bHdibWVPwungr/otZjw4la
 cHYMq+PGWzh8S8lGA1+b1scnxJjytxU=
X-Google-Smtp-Source: APXvYqxw2pppNI71tYBZz3Hgt3TKpK6KvPMLpijq+24otX3ecATOZMmlnXc/XbCoiauaclkEVvYnrQ==
X-Received: by 2002:a63:f40e:: with SMTP id g14mr5641397pgi.62.1570813841278; 
 Fri, 11 Oct 2019 10:10:41 -0700 (PDT)
Received: from localhost (li2016-34.members.linode.com. [172.105.123.34])
 by smtp.gmail.com with ESMTPSA id z189sm8934678pgz.53.2019.10.11.10.10.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Oct 2019 10:10:40 -0700 (PDT)
From: Li Guifu <blucerlee@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v4][ 2/2] erofs-utils: fix error handler notes when parameter
 miss
Date: Sat, 12 Oct 2019 01:09:53 +0800
Message-Id: <20191011170953.6267-2-blucerlee@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011170953.6267-1-blucerlee@gmail.com>
References: <20191011170953.6267-1-blucerlee@gmail.com>
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

If a parameter isnot input, mkfs's error handler cannot give
a correct notes, fix it.

Signed-off-by: Li Guifu <blucerlee@gmail.com>
---
 mkfs/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 77a4b78..adfc79c 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -143,7 +143,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	if (!cfg.c_img_path)
 		return -ENOMEM;
 
-	if (optind > argc) {
+	if (optind >= argc) {
 		erofs_err("Source directory is missing");
 		return -EINVAL;
 	}
-- 
2.17.1

