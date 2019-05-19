Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id D329A2267B
	for <lists+linux-erofs@lfdr.de>; Sun, 19 May 2019 11:34:59 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 456H1Y2nHlzDqJR
	for <lists+linux-erofs@lfdr.de>; Sun, 19 May 2019 19:34:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=hariprasad.kelam@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="IrPi4dzj"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 456H1P1gmWzDqHw
 for <linux-erofs@lists.ozlabs.org>; Sun, 19 May 2019 19:34:49 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id t187so5320100pgb.13
 for <linux-erofs@lists.ozlabs.org>; Sun, 19 May 2019 02:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:mime-version:content-disposition
 :user-agent; bh=11epPDMxJKikdDuH5v438Dqzhu+8xiuwN8/dlEEPf7w=;
 b=IrPi4dzjuT6IuaUnXQW4C/RlKY8SAQGAI5efWh0a40wMRM8t2LHgHcz1avoKtU3abK
 bFUrCDyneTCImqczkLbYkM6PeugMcl6RjCaBzPHsUMb2p2Qfu+d2cdlSbWEhnOqUdzd4
 2H6Hc9rb8zKSVSzvYcSMEXscOSsySGNNd1unU/69ZUdiwH8CToKoW11BzMulBk5jOYJa
 +H0GbeS85k3CzVc3RfSojyBPlo6/khO7Y7mF0IU6XLofQ4eJlBUFLEtkP0hBnuCAZJyx
 VZwLlivrukrcR2MuFInFQFIZ+SZZZvgRjujyAsXkfkLjoB7fGeVs54Ztp/RiBvut1iUN
 UlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=11epPDMxJKikdDuH5v438Dqzhu+8xiuwN8/dlEEPf7w=;
 b=tz6MqpFKQliukVgaPPzsBQCeuEITwzuUVOrRZXVO7kS8R2ZRN9AlYEPIHNRqVW/g4P
 2YhkcP0GeF7du2L7OGmUZex1xPsNWp1FQFNuStNw3VNiSIZy26a/Rj8WNGlRYJY20agg
 lOB/HeBQbxFZN9k1IKS2WtR87D53efX5PpETf0G2Jh6ZU9Y4Zkv8C68tvWnW67eoVnB9
 1W3gQ+BxS1sn6rIRWgIgzzJeUgENVaPTsPu9KK9nvn/bI4nbHzX/Kg1IsxQyQoMpSjxv
 X0BRf6n+fgKWI4/frBsdp9IIWJ9RGQfi9ygIltaNeR7k7QsGxxNKok1MEZds4Z+wyr1i
 bCkg==
X-Gm-Message-State: APjAAAVqrgMPb7ltymrQzhXnJ1TktF9GPJcAcrW3H76P/Y7woivm9R2P
 gPh5idx5ynv/+X8yzYJbnJU=
X-Google-Smtp-Source: APXvYqxvavbTr5Llg15jkn4mHoaZyPh1phIxnZxhyXOoqbUxbMz6gbjUaChu1TIA3y6jx3n1pcJ2/A==
X-Received: by 2002:a63:7141:: with SMTP id b1mr68253806pgn.331.1558258486280; 
 Sun, 19 May 2019 02:34:46 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
 by smtp.gmail.com with ESMTPSA id w189sm16622660pfw.147.2019.05.19.02.34.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 19 May 2019 02:34:45 -0700 (PDT)
Date: Sun, 19 May 2019 15:04:40 +0530
From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
To: Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: [Patch v2] staging: erofs: fix Warning Use BUG_ON instead of if
 condition followed by BUG
Message-ID: <20190519093440.GA16838@hari-Inspiron-1545>
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
-----
Changes in v2:
  - replace BUG_ON with  DBG_BUGON
-----
---
 drivers/staging/erofs/unzip_pagevec.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/erofs/unzip_pagevec.h b/drivers/staging/erofs/unzip_pagevec.h
index f37d8fd..7938ee3 100644
--- a/drivers/staging/erofs/unzip_pagevec.h
+++ b/drivers/staging/erofs/unzip_pagevec.h
@@ -70,8 +70,7 @@ z_erofs_pagevec_ctor_next_page(struct z_erofs_pagevec_ctor *ctor,
 			return tagptr_unfold_ptr(t);
 	}
 
-	if (unlikely(nr >= ctor->nr))
-		BUG();
+	DBG_BUGON(nr >= ctor->nr);
 
 	return NULL;
 }
-- 
2.7.4

