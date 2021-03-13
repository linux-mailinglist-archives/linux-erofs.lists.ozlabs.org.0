Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3885D339E11
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Mar 2021 13:41:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DyMjy0Qwnz3bVW
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Mar 2021 23:41:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OKfiQcAh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dZta7Ggs;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=OKfiQcAh; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dZta7Ggs; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DyMjs5NSjz2xZp
 for <linux-erofs@lists.ozlabs.org>; Sat, 13 Mar 2021 23:41:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615639258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=eagCFlIDHMIudK4vof/BRyU/fRgM/eIedg5D6cKZPVI=;
 b=OKfiQcAh/OOWl9VkGvIbd24DETtUdxYKZ8kJschuW0aq+FS+JNOFo+3Qpv3sg0A14MXfye
 tb98gPEjvKbL3fcuGdInZexo9fx4NAvioh1A/7VHBoeHbatM/7Hav4oi8IWjAZwiLqu0nu
 xg5uMmNwjCnm60o0FKCFOc28iYlz0U0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615639259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=eagCFlIDHMIudK4vof/BRyU/fRgM/eIedg5D6cKZPVI=;
 b=dZta7GgsxxXWPvKyg7/WSOOlF4yDMsBUyz5xaHIvL5RgVs08i9hkiexzuiLANp7GnXdNNv
 EFPDe304Z54/oaBthgbFsvSy7nRn3b1in62Ofu9rAG9p0zK9JqZdNduM/fM0MOexr4a0KI
 X6UtesbsO+iwi3nW1Hl4o1dqmpqJV4E=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-aal2bWVPNkSgRsPj1gtOlQ-1; Sat, 13 Mar 2021 07:40:56 -0500
X-MC-Unique: aal2bWVPNkSgRsPj1gtOlQ-1
Received: by mail-pg1-f199.google.com with SMTP id y26so14694955pga.10
 for <linux-erofs@lists.ozlabs.org>; Sat, 13 Mar 2021 04:40:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=eagCFlIDHMIudK4vof/BRyU/fRgM/eIedg5D6cKZPVI=;
 b=YzOFQhl75RgDvTBoZc9Bsz3pcb5XptDiO+Y1XnTySV8MNcwKscNwdTGsNfiTMBnP7X
 Zhkc2C3FfTMYdvpKfdZGw0ZOpBo6aIXmxShi6DPYOMQwhKDpH0vYmXSUMn0b0RzO8cOb
 jNakhyLSOiFZ74G8bzzbZWq7CpnD1ilpJA4xMNPHBTZsddnZUU5Ckj1WxxeUcC7GVh8S
 Lxn009bQOoYBmFk5pQnkUV8L3axZrm75W5lI8eAa1HwuHuKx0ml+YwRp/3MlioyUBErU
 raJ4LEskVr29M/BOdeiiS/1U1926EnHy3tCyK2yf8BKqXLRqoEE6NYbX5w1pG7BVigE+
 Uhtg==
X-Gm-Message-State: AOAM532PNEkk07jMxN3DWHmecgfkWQ5Yv5vcD/p7Zjway/Zbhj8I2K6t
 jsLYpBJFUidYjbg7QTat3kk5CC9R8EJfLtxfLcRwasb2/6H3dhWmW0QZq02rJbBEAu3DaOizLy0
 FdCl4G8/mxzjrucmjhT3zc88p
X-Received: by 2002:a63:fb18:: with SMTP id o24mr15495315pgh.55.1615639255519; 
 Sat, 13 Mar 2021 04:40:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytP436HyeGcc23xgylTsiHMzCO6hv5nMP+KgzqnRJZfCRlztmbsqPrh1SjFQGmJRPSNmOR1A==
X-Received: by 2002:a63:fb18:: with SMTP id o24mr15495303pgh.55.1615639255279; 
 Sat, 13 Mar 2021 04:40:55 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id w18sm5016788pjh.19.2021.03.13.04.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Mar 2021 04:40:54 -0800 (PST)
Date: Sat, 13 Mar 2021 20:40:44 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs fix for 5.12-rc3
Message-ID: <20210313124044.GA488856@xiangao.remote.csb>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: Martin DEVERA <devik@eaxlabs.cz>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider this pull request for 5.11-rc3?
All details about this new regression are as below.

All commits have been tested and have been in -next for days.
This merges cleanly with master.

Thanks,
Gao Xiang

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.12-rc3

for you to fetch changes up to 9f377622a484de0818c49ee01e0ab4eedf6acd81:

  erofs: fix bio->bi_max_vecs behavior change (2021-03-08 10:43:32 +0800)

----------------------------------------------------------------
Change since last update:

Fix an urgent regression introduced by commit baa2c7c97153 ("block:
set .bi_max_vecs as actual allocated vector number"), which could
cause unexpected hung since linux 5.12-rc1.

Resolve it by avoiding using bio->bi_max_vecs completely.

----------------------------------------------------------------
Gao Xiang (1):
      erofs: fix bio->bi_max_vecs behavior change

 fs/erofs/data.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

