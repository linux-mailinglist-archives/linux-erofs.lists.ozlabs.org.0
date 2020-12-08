Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id F286D2D2153
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 04:14:41 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cqlf720GszDqXg
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 14:14:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=TIhed8bO; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TIhed8bO; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cqlf03tCzzDqW4
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Dec 2020 14:14:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607397266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mthuFi5TW9YsKTeZpnIHZUZ93ckX2z2UHw2lFllgY/0=;
 b=TIhed8bOwJ6uzgkc9VAfoWSw2dRqsE4hTczOhgR5Mh8YBqEy+sBfIq0VmUKG6BkTgfLQB+
 CKAnjheT5Gabqi/zkOaRIIADindLNHQYWpPrM1zxcm/QsGPsbXEKptMVCRl/zwL33HvUsJ
 H/YKhSrSjOPDnzohrzqwQT1W/hbzrBo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607397266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mthuFi5TW9YsKTeZpnIHZUZ93ckX2z2UHw2lFllgY/0=;
 b=TIhed8bOwJ6uzgkc9VAfoWSw2dRqsE4hTczOhgR5Mh8YBqEy+sBfIq0VmUKG6BkTgfLQB+
 CKAnjheT5Gabqi/zkOaRIIADindLNHQYWpPrM1zxcm/QsGPsbXEKptMVCRl/zwL33HvUsJ
 H/YKhSrSjOPDnzohrzqwQT1W/hbzrBo=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-2VZ1zaJfOPO_zI2K2H6Qxg-1; Mon, 07 Dec 2020 22:14:24 -0500
X-MC-Unique: 2VZ1zaJfOPO_zI2K2H6Qxg-1
Received: by mail-pl1-f198.google.com with SMTP id c12so5979346pll.12
 for <linux-erofs@lists.ozlabs.org>; Mon, 07 Dec 2020 19:14:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=mthuFi5TW9YsKTeZpnIHZUZ93ckX2z2UHw2lFllgY/0=;
 b=D9zHrRLrchBllrzrlKPvbJLXeuIhi5qtOujj7RaHSEfndNuk56HfKZ0l4amqHUMIJB
 bajyQoccP1Mgw8MGraMPuhGrB0qxwvWFFk1f3QGbDcxC8JvtO8tymXGzQwrTSQcNtu1t
 6L53haEbZ32KhTHKcIaqqQsO36THLRNK5MNJ9RSzNw+CryO/JsNh9VKis4GSe60tgOVe
 2KWu8rwVfMNH8X1/NqUPrTX4xrZO7S9BMnQ8z53Ynbim/QhcOYht84VYPQ+QssMNHFsc
 R16uH8wDeDWIlY3fMUIjrggtvNGAUaes7/tjNSifdUw9Jm6psbKkDlfy3EGRcdcmyS22
 7oqw==
X-Gm-Message-State: AOAM532DH8xMiNmxj3jZx69Gvb5oVZGsHrLFwSnjp1P4trC0nN8ukPO6
 QQEIpKNxrDSiDk1DSeQVqiUlSZMgoiwJyC5p2Mql/wonhBc1hOC9qoPcmiL2duC5XXbEpclmY9b
 VKGa/vWyfp7fiICDNAoZGuHuouyAhc8u3qDpaYzFVn/KESDIVwCAUPOye99HAvqMuUyACxsIKg8
 10+Q==
X-Received: by 2002:a63:1346:: with SMTP id 6mr21055469pgt.330.1607397263396; 
 Mon, 07 Dec 2020 19:14:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyL9m0kS6AeCJmmwicuLitmZb+KGqh/Eyv/pgMonwN3yI3VDUnAIQSSKutvLGtoYviZJC0HeQ==
X-Received: by 2002:a63:1346:: with SMTP id 6mr21055447pgt.330.1607397263111; 
 Mon, 07 Dec 2020 19:14:23 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c6sm13738832pgl.38.2020.12.07.19.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Dec 2020 19:14:22 -0800 (PST)
Date: Tue, 8 Dec 2020 11:14:12 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v2 1/3] erofs: get rid of magical Z_EROFS_MAPPING_STAGING
Message-ID: <20201208031412.GA3006985@xiangao.remote.csb>
References: <20201207012346.2713857-1-hsiangkao@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201207012346.2713857-1-hsiangkao@redhat.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chao,

On Mon, Dec 07, 2020 at 09:23:44AM +0800, Gao Xiang wrote:
> Previously, we played around with magical page->mapping for short-lived
> temporary pages since we need to identify different types of pages in
> the same pcluster but both invalidated and short-lived temporary pages
> can have page->mapping == NULL. It was considered as safe because that
> temporary pages are all non-LRU / non-movable pages.
> 
> This patch tends to use specific page->private to identify short-lived
> pages instead so it won't rely on page->mapping anymore. Details are
> described in "compress.h" as well.
> 
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> ---
> tested with ro_fsstress for a whole night.
> 
> The old "[PATCH 4/4] erofs: complete a missing case for inplace I/O" is
> temporarily dropped since ro_fsstress failed with such modification,
> will look into later.
> 

Do you have some extra bandwidth to review these commits?
plus a commit from Vladimir Zapolskiy:
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git/commit/?id=c8390cfaa07cb9e9ccaa946a1919b69dfb34bad1

The merge window will be open the next week. I have to prepare
the submission from now.

Thanks,
Gao Xiang

