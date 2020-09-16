Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id C783426C3C7
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Sep 2020 16:37:16 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bs2k00gW4zDqZ3
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Sep 2020 00:37:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=205.139.110.120;
 helo=us-smtp-1.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=e2gwie+n; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=e2gwie+n; 
 dkim-atps=neutral
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bs2jr4y4FzDqXq
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Sep 2020 00:37:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600267020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MTHeqxpIT8EXX6m2+ZlNqDXIIS9Amzc0XcLnbyVZ7dQ=;
 b=e2gwie+nPArKthKJOapbbjCM1iChxfycKqB3qjQr4Wu7zFrq2tdoa4HIMHqAVphYuyJkTG
 7qp0boh8uSR7W7eIYcZttItpF3KFVsA+28g0sVjgduDxi7BYu8pLRLGsaLUMxnyA6A9EjL
 ZOiHpnchleWVkjc+nJ0ZDOw70WOW7bw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600267020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MTHeqxpIT8EXX6m2+ZlNqDXIIS9Amzc0XcLnbyVZ7dQ=;
 b=e2gwie+nPArKthKJOapbbjCM1iChxfycKqB3qjQr4Wu7zFrq2tdoa4HIMHqAVphYuyJkTG
 7qp0boh8uSR7W7eIYcZttItpF3KFVsA+28g0sVjgduDxi7BYu8pLRLGsaLUMxnyA6A9EjL
 ZOiHpnchleWVkjc+nJ0ZDOw70WOW7bw=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-ltxRUNE3MkuS4O2YV9Xsrw-1; Wed, 16 Sep 2020 10:36:59 -0400
X-MC-Unique: ltxRUNE3MkuS4O2YV9Xsrw-1
Received: by mail-pf1-f197.google.com with SMTP id 8so4053801pfx.6
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Sep 2020 07:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=MTHeqxpIT8EXX6m2+ZlNqDXIIS9Amzc0XcLnbyVZ7dQ=;
 b=WXLk5iWDAnjmfpDWPOJnAYY0aJxBQ/l+aBdzKEfHyhHBIHXgHFUxNHdQeQjZoI2dsJ
 nW0RCsxdB/SH43QTZ4tuhYIAI5RzwhsHGe1hDDAnaBMuAAiVLnLCJpioaKd2i2R959z1
 zl2U4WNKmX4ARt9OXu12m3QoQ6iURp+D9D0DNzXzYHaUvYdEw+dO0fjeS0Ondyu96JMG
 dZoAvdVOnG1ySrppG8SJ3abXR3jrk9NAkM5I1E87Q/KjiEtzjQLJPj8vwLJBjOqqLHWz
 w3S9+kBhNhBv1x72k+B4zD2bfr44M99W3YnrhKUwimxftU5CP0TPp7Q2brbGeGn2IJ2Q
 5yQg==
X-Gm-Message-State: AOAM532H+hbhRzVujov99C47uItg6PsygoGTNyPrV0L3wUxfyc5pfzCe
 FN+NPPUph2WT34B6LR+lhwxhjwynlJtn4EsyJc1lBCxo+h1/XL32Df4wiQvuIF6gSEsoZ0d1kAP
 4pDp0Ze3j9WlvEljO2rzCisAH
X-Received: by 2002:a63:4746:: with SMTP id w6mr18998068pgk.412.1600267018013; 
 Wed, 16 Sep 2020 07:36:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydrD4AmJjitwyeWDobFc34EF1rDeWZ1E+AnBFNtqYiQ3U/wMM8WIEa3qQKrM57pGjzqu0/mQ==
X-Received: by 2002:a63:4746:: with SMTP id w6mr18998053pgk.412.1600267017786; 
 Wed, 16 Sep 2020 07:36:57 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b29sm15071706pgb.71.2020.09.16.07.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 07:36:57 -0700 (PDT)
Date: Wed, 16 Sep 2020 22:36:48 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] erofs: remove unneeded parameter
Message-ID: <20200916143648.GA23921@xiangao.remote.csb>
References: <20200916140604.3799-1-chao@kernel.org>
 <20200916143304.GA23176@xiangao.remote.csb>
MIME-Version: 1.0
In-Reply-To: <20200916143304.GA23176@xiangao.remote.csb>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Sep 16, 2020 at 10:33:04PM +0800, Gao Xiang wrote:
> Hi Chao,
> 
> On Wed, Sep 16, 2020 at 10:06:04PM +0800, Chao Yu wrote:
> > From: Chao Yu <yuchao0@huawei.com>
> > 
> > In below call path, no page will be cached into @pagepool list
> > or grabbed from @pagepool list:
> > - z_erofs_readpage
> >  - z_erofs_do_read_page
> >   - preload_compressed_pages
> >   - erofs_allocpage
> > 
> > Let's get rid of this unneeded parameter.
> 
> That would be unneeded after .readahead() is introduced recently
> (so add_to_page_cache_lru() is also moved to mm code), so I agree
> with you on it.

(cont.)

... also it'd be better to add such historical reason to the commit
message... since it was of some use before...

Thanks,
Gao Xiang

