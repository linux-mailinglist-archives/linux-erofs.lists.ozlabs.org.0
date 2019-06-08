Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E72E039C3E
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Jun 2019 11:49:35 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45LZP92RktzDqHp
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Jun 2019 19:49:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=hariprasad.kelam@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZOHbvL/S"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45LZP24mz7zDqFS
 for <linux-erofs@lists.ozlabs.org>; Sat,  8 Jun 2019 19:49:26 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id d126so2555447pfd.2
 for <linux-erofs@lists.ozlabs.org>; Sat, 08 Jun 2019 02:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:mime-version:content-disposition
 :user-agent; bh=ceB58BsT2jhuXKLvpsF6nc1EbvAVeMuXaSf+CtPNzlg=;
 b=ZOHbvL/SIifcsBkKsIMBtCrqGGFpB9o8aoUYAqXaYK5rea2+tx1pKid0Xi8Vynev58
 f4lILw2GUYXpeCcgNH6FgWHFCQaUtzuGBRUWW48lR3mLLdEZv9dsA1qa9AUccDBNi22I
 FgsktcRehMLN1neRxc76Eny2dhNClfBg9lqgOzMnQoQykFEJW79rJ6r5sHMy70/8OX7y
 2sLhGA1S2c1im9T5w19fWhB6zgCHOChLxh+z3iWJNKNclF2wDv5mkWF/sxsNjI6OO3je
 NO3scrCxGmlU6VWSp9bmE2IM6I/n0jD+PCx/zfE5FgHtmru881NJywKLdNRLfXXsSYdj
 onpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=ceB58BsT2jhuXKLvpsF6nc1EbvAVeMuXaSf+CtPNzlg=;
 b=WJ/lGOWnMOGpc2qf4JNTeQbaLXvv4w7B3qBI56kfomQtFgHCWh1CuvSl9judRn1jSt
 abwiCmQ0GqrCz2GHHDc3PhFgbGSZnSeA6PJvYYXCdC7f12uAowOFWvbk+5wI17gXJ/rD
 v287nSyNZLKx6jObLVozJdZrEkY8iQV1jaWH1DuWFUYQ73d6NkRKB28Ha4yAKJACklv+
 idOAEiIazcSDAz1FoskDpSnPVEIZEhqpxRdzu8Gqr36Ck7SaIemVosOq7b2fyyND9HzR
 QaQpeKi0baNicouL2f5HZLcI9AvkivOndqcRxMSHiMiORAozHn+MU1NdDYC0uerZyiG1
 ySuQ==
X-Gm-Message-State: APjAAAWzjIMBSWQsHPRdfBmb6RW9PsR8gjTUipEoIAr8vjUAH0WhfuHE
 isOP8ikMdSnH5Hq6OMgvA0E=
X-Google-Smtp-Source: APXvYqynnyl6j4lWBQSS4y8CNh8+wxRD6csIB5VrA1DZZsD6AFefijgTYBS9fQJ9CefQtd5iIsDANQ==
X-Received: by 2002:a62:65c7:: with SMTP id z190mr63825619pfb.73.1559987363342; 
 Sat, 08 Jun 2019 02:49:23 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
 by smtp.gmail.com with ESMTPSA id z11sm4017605pjq.13.2019.06.08.02.49.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Jun 2019 02:49:22 -0700 (PDT)
Date: Sat, 8 Jun 2019 15:19:18 +0530
From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
To: Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] staging: erofs: make use of DBG_BUGON
Message-ID: <20190608094918.GA11605@hari-Inspiron-1545>
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

DBG_BUGON is introduced and it could only crash when EROFS_FS_DEBUG
(EROFS developping feature) is on.
replace BUG_ON with DBG_BUGON.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/erofs/unzip_vle.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.h b/drivers/staging/erofs/unzip_vle.h
index 517e5ce..902e67d 100644
--- a/drivers/staging/erofs/unzip_vle.h
+++ b/drivers/staging/erofs/unzip_vle.h
@@ -147,7 +147,7 @@ static inline unsigned z_erofs_onlinepage_index(struct page *page)
 {
 	union z_erofs_onlinepage_converter u;
 
-	BUG_ON(!PagePrivate(page));
+	DBG_BUGON(!PagePrivate(page));
 	u.v = &page_private(page);
 
 	return atomic_read(u.o) >> Z_EROFS_ONLINEPAGE_INDEX_SHIFT;
@@ -179,7 +179,7 @@ static inline void z_erofs_onlinepage_fixup(struct page *page,
 		if (!index)
 			return;
 
-		BUG_ON(id != index);
+		DBG_BUGON(id != index);
 	}
 
 	v = (index << Z_EROFS_ONLINEPAGE_INDEX_SHIFT) |
@@ -193,7 +193,7 @@ static inline void z_erofs_onlinepage_endio(struct page *page)
 	union z_erofs_onlinepage_converter u;
 	unsigned v;
 
-	BUG_ON(!PagePrivate(page));
+	DBG_BUGON(!PagePrivate(page));
 	u.v = &page_private(page);
 
 	v = atomic_dec_return(u.o);
-- 
2.7.4

