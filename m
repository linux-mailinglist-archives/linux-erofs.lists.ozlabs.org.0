Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id DD92839C35
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Jun 2019 11:39:58 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45LZB42XklzDqZb
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Jun 2019 19:39:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=hariprasad.kelam@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="TAMq7WgC"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45LZ9v47lhzDqLD
 for <linux-erofs@lists.ozlabs.org>; Sat,  8 Jun 2019 19:39:45 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id 81so2520255pfy.13
 for <linux-erofs@lists.ozlabs.org>; Sat, 08 Jun 2019 02:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:mime-version:content-disposition
 :user-agent; bh=zUjxWxq5BrI2FdDPrseDzMNtgvtMjERhQiQzZo7nm7E=;
 b=TAMq7WgCUSTJYkkb+calodVXAtvnqOeZde9ehQHvFCXrubzN4fWZzQgbwa8bHq6C1M
 AtlxxKBDISu2nzuZWa7xYljbMFCEcOW2kExJ03L/SfOpiQzq5Ai0mx5W/TmR98lz+mpe
 88iVjnMKH+Xop89CHXoJOZv30UlNude7LIPzdm3mXq02qdVDII3LTCzxmihX2CGPZbSd
 hO4mazSLbrevzHNGJvMUtuImLT+94ajD0mJ7QdK3WORuMX0Pdm/aEDRWyHofxctadCmM
 5nwENFnPVVc+BtTwLLLMehuDKltXUs6zVZdOlqPgBnVVXlVYUnMy9mOZNmql49weDNe6
 hhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=zUjxWxq5BrI2FdDPrseDzMNtgvtMjERhQiQzZo7nm7E=;
 b=ZHQKQBCrCxWob6iQN5SLwsAoa2mk3+xovKJjeAPdEWPYrjQd4EOX3vg4OOwcYHQnbb
 QO9TM3euynVa3HmlcqUotjiSEnlRrQxoAIy/Uk/0TyJMCKP6AY2IXPY+uw1kYeO/h9xF
 tSqGKHQW7UKeXs9Ubdxxd8fYpYpgCzI5dj9kQyqUA0iUZuRlhWytUfGZfIy5RrYOGu3s
 Gw/gvw14mpxynk4XJs1QnZH/ZUwOiz4RKkLHEKppEW5Dr69geoUHNhrj1skpwMSvjm/J
 ULELR+qB0MOaH1x9cI9OEiykoM6ax6AbySukxkoeZEKHgUNcHTWJbW4RGO89x3iZV/hg
 fzSA==
X-Gm-Message-State: APjAAAWU/ViXZ2dkP4nE+5svyAkXI93lprbIrXZ47d6NfdE9tGZxB9jK
 hcL7j5d5dpA/9OP7IRpGQ0k=
X-Google-Smtp-Source: APXvYqwiTuXWweBI9kCIpvuh3BS9bBAfUi5CdTkOsKqi9kmZQJOXNb+PRo+WIyuorc2QmIo1ixGesA==
X-Received: by 2002:a62:4c5:: with SMTP id 188mr63276002pfe.19.1559986781709; 
 Sat, 08 Jun 2019 02:39:41 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
 by smtp.gmail.com with ESMTPSA id 66sm4883523pfg.140.2019.06.08.02.39.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Jun 2019 02:39:41 -0700 (PDT)
Date: Sat, 8 Jun 2019 15:09:37 +0530
From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
To: Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] staging: erofs: fix warning Comparison to bool
Message-ID: <20190608093937.GA10461@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
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

fix below warnings reported by coccicheck

drivers/staging/erofs/unzip_vle.c:332:11-18: WARNING: Comparison to bool

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/erofs/unzip_vle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 9ecaa87..f3d0d2c 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -329,7 +329,7 @@ try_to_claim_workgroup(struct z_erofs_vle_workgroup *grp,
 		       z_erofs_vle_owned_workgrp_t *owned_head,
 		       bool *hosted)
 {
-	DBG_BUGON(*hosted == true);
+	DBG_BUGON(*hosted);
 
 	/* let's claim these following types of workgroup */
 retry:
-- 
2.7.4

