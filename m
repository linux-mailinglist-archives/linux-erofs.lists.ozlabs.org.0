Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5AE22441
	for <lists+linux-erofs@lfdr.de>; Sat, 18 May 2019 19:33:55 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 455shb6Rc0zDqNs
	for <lists+linux-erofs@lfdr.de>; Sun, 19 May 2019 03:33:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=hariprasad.kelam@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="auLY2NMG"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 455shV4K9DzDqNW
 for <linux-erofs@lists.ozlabs.org>; Sun, 19 May 2019 03:33:40 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id g9so5178562pfo.11
 for <linux-erofs@lists.ozlabs.org>; Sat, 18 May 2019 10:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:mime-version:content-disposition
 :user-agent; bh=pBUOpcZZhVnAEMzK2Qi13gp5BqUlujzgGPYXraDy+LU=;
 b=auLY2NMGRP93XGfuqVGmCFv10ilgSNvE32chNovFfE3hNYk+VsNegdj6oqOIFK73I8
 nyRJu8ucZYf9s/GnyxmcyL1TYCVAB8kgcSbw2EBPUo1O27isB1yk6MS1MoqMAXBD4tyt
 0o/2CbJmzo8YtOYlwlReJ2LTMk3330zP9twY45DZrszNfoE33pyL5rUYIYgZeKd9XUmD
 wdRxsywK2ENZRtEyaBQpGCWr5teezmZIRu83oMej7Cer77vKEQdQ5jv8UIiba4yaFrVK
 ZbheqtkH6gSt8mF/FDGh0HjKmeHUgjwWuD/oHMX52RIBM0oCj3XQz2PH6CtLkwnzARoT
 blZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=pBUOpcZZhVnAEMzK2Qi13gp5BqUlujzgGPYXraDy+LU=;
 b=TQC4PfLjAyr/1EG+jBZdVWMEDe6T53YB4En5D5Eas4KXu1b5afX9gr9OIJL209cgac
 GuCA9EjaYnCe2IsZjVQXeCvC+M9iAbcEZoBQvz3eZQpN9y621J6dI4/xfuG/d5DFuZty
 uqhVxXKexlH6yN2BSHK6y6w+Xk5doCbp9givw1Q5zfRVbeuS87JwTicwFalE1XwC9gmI
 JOooHpIDpGdR2jCqmAxaTzso7Snkx0h0jA0uc9tcIi4KFMpZiyzhlJdIDuvZUmcvsAyg
 jvGVUrLPCX4RrkurYHBteiPxV2i7YhrRbxYd2jhNogeSgh+sKkmr/1ff+N41x2ZBKSSY
 aPcg==
X-Gm-Message-State: APjAAAWsCXnisvYOSE9hrc8hwx8gXZYTO9cuMGDwOTG/B0Frp7GEaTdo
 j7v3rQFFXh0n5sQwOhRRkXA=
X-Google-Smtp-Source: APXvYqxWJTJIdCpHS0U/FnQzuWH0oWUVKu8hlU6RfRmLRWX081s6/gamZSeSuCmsOfOw34bD/oX0jQ==
X-Received: by 2002:a63:c54d:: with SMTP id g13mr65078775pgd.376.1558200817033; 
 Sat, 18 May 2019 10:33:37 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
 by smtp.gmail.com with ESMTPSA id n21sm15160229pgf.28.2019.05.18.10.33.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 18 May 2019 10:33:36 -0700 (PDT)
Date: Sat, 18 May 2019 23:03:31 +0530
From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
To: Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] staging: erofs: fix Warning Use BUG_ON instead of if
 condition followed by BUG
Message-ID: <20190518173331.GA1069@hari-Inspiron-1545>
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

fix below warning reported by  coccicheck

drivers/staging/erofs/unzip_pagevec.h:74:2-5: WARNING: Use BUG_ON
instead of if condition followed by BUG.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/erofs/unzip_pagevec.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/erofs/unzip_pagevec.h b/drivers/staging/erofs/unzip_pagevec.h
index f37d8fd..0f61c54 100644
--- a/drivers/staging/erofs/unzip_pagevec.h
+++ b/drivers/staging/erofs/unzip_pagevec.h
@@ -70,8 +70,7 @@ z_erofs_pagevec_ctor_next_page(struct z_erofs_pagevec_ctor *ctor,
 			return tagptr_unfold_ptr(t);
 	}
 
-	if (unlikely(nr >= ctor->nr))
-		BUG();
+	BUG_ON(nr >= ctor->nr);
 
 	return NULL;
 }
-- 
2.7.4

