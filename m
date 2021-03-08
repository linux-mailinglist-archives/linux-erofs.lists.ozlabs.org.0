Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF92D3305EA
	for <lists+linux-erofs@lfdr.de>; Mon,  8 Mar 2021 03:37:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dv2YR6Glvz3cK8
	for <lists+linux-erofs@lfdr.de>; Mon,  8 Mar 2021 13:37:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gbAQGyvG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gbAQGyvG;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=gbAQGyvG; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gbAQGyvG; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dv2YN2GVFz2ysq
 for <linux-erofs@lists.ozlabs.org>; Mon,  8 Mar 2021 13:37:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615171025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tv+IGQw5DDfzRJXz4JnZH5Nwua0J/9SIbyygH+7TcgA=;
 b=gbAQGyvGUjPG+tVYBNFZYBBvosXsdVGle21xpdKYFL73PcN1+g586GuEcAku9XP44LJkSz
 cSI5hwELeOYYRJGEyxz/Vc4Hs55qpAzVUfrIzacKX+37iehVg873/gqdd+9eVXcFbpOFnh
 +/0FOlYpbBj4+p3w8wSDmrvxJa9HWOs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615171025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tv+IGQw5DDfzRJXz4JnZH5Nwua0J/9SIbyygH+7TcgA=;
 b=gbAQGyvGUjPG+tVYBNFZYBBvosXsdVGle21xpdKYFL73PcN1+g586GuEcAku9XP44LJkSz
 cSI5hwELeOYYRJGEyxz/Vc4Hs55qpAzVUfrIzacKX+37iehVg873/gqdd+9eVXcFbpOFnh
 +/0FOlYpbBj4+p3w8wSDmrvxJa9HWOs=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-XZejyKulMgmwaB3jH-KoAA-1; Sun, 07 Mar 2021 21:37:03 -0500
X-MC-Unique: XZejyKulMgmwaB3jH-KoAA-1
Received: by mail-pl1-f200.google.com with SMTP id w10so1011072plc.20
 for <linux-erofs@lists.ozlabs.org>; Sun, 07 Mar 2021 18:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tv+IGQw5DDfzRJXz4JnZH5Nwua0J/9SIbyygH+7TcgA=;
 b=o+1bRMnpx7/w8NLh8yBhokgLkxPf6x5xvyGQF7pgn8wgRQFgYovnnvXfvieje3drUR
 0i5seMV0tWm9ewH5gmwAVXily1/AcLPPIzw+mU/N6sEnDoXA14BacCyiEMWF8/JQJHsZ
 U7O/9aOKe1BoNNrQ+6qCdCoIt0jgqAuFKSgIxzkUDaJ9N1WPGNb/HmVZg4ps1vrgUL3L
 tXlaFt8cpUW7RpWNRdnOpVRTtehQ0OAhoPv7HE9uDfg5j9605fzpCZXAlILbOi2xUrTI
 gf7o0kEVykD4yGZ6XglBnzyIya5329PP2ctem0aLnryQvds8vvMuCepw08FKHRfnw3hw
 yk/w==
X-Gm-Message-State: AOAM533If5Wj0UdP+T6wdISJCuJZCT+8idDDi3o4Zw1XSHssEwGBtyCI
 Xs0aKQbN9VGzMGxS1OOe/dF5186X4tYDVguZ8BihdSV/JieXBS2QA1xOTRfv8Du5trzcuVQ+K2p
 xsDkJiH/JiIGbTIO9qH+hN72i
X-Received: by 2002:a17:90a:c201:: with SMTP id
 e1mr22224081pjt.30.1615171022626; 
 Sun, 07 Mar 2021 18:37:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxyWJ5ARLYHECViOuZrdjRWC3Z1BPEm2Fsc3JcmbqCl+3rC0+udhl+NJJDYr9X0RekLDHAFg==
X-Received: by 2002:a17:90a:c201:: with SMTP id
 e1mr22224071pjt.30.1615171022471; 
 Sun, 07 Mar 2021 18:37:02 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id f20sm8594922pfa.10.2021.03.07.18.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Mar 2021 18:37:02 -0800 (PST)
Date: Mon, 8 Mar 2021 10:36:50 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] erofs: fix bio->bi_max_vecs behavior change
Message-ID: <20210308023650.GA3537842@xiangao.remote.csb>
References: <20210306033109.28466-1-hsiangkao@aol.com>
 <20210306040438.8084-1-hsiangkao@aol.com>
 <6525c63c-a6e2-8c39-6c9a-1ca9b54632d8@huawei.com>
MIME-Version: 1.0
In-Reply-To: <6525c63c-a6e2-8c39-6c9a-1ca9b54632d8@huawei.com>
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
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chao,

On Mon, Mar 08, 2021 at 09:29:30AM +0800, Chao Yu wrote:
> On 2021/3/6 12:04, Gao Xiang wrote:
> > From: Gao Xiang <hsiangkao@redhat.com>
> > 
> > Martin reported an issue that directory read could be hung on the
> > latest -rc kernel with some certain image. The root cause is that
> > commit baa2c7c97153 ("block: set .bi_max_vecs as actual allocated
> > vector number") changes .bi_max_vecs behavior. bio->bi_max_vecs
> > is set as actual allocated vector number rather than the requested
> > number now.
> > 
> > Let's avoid using .bi_max_vecs completely instead.
> > 
> > Reported-by: Martin DEVERA <devik@eaxlabs.cz>
> > Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> 
> Looks good to me, btw, it needs to Cc stable mailing list?
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 

Thanks for your review. <= 5.11 kernels are not impacted.
For now, this only impacts 5.12-rc due to a bio behavior
change (see commit baa2c7c97153). So personally I think
just leave as it is is fine.

Thanks,
Gao Xiang

> Thanks,
> 

