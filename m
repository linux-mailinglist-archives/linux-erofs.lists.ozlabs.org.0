Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A2B2D36E0
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 00:25:23 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CrGW44hsZzDqjY
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 10:25:20 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=ZKSdAx+w; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZKSdAx+w; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CrGV00SHCzDqkR
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Dec 2020 10:24:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607469860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/H1enNHQxNS8h9E+mm8W+uBp7Qvj7G13FO1FCnQAIBs=;
 b=ZKSdAx+wAu3Wbq7o2MpyptColUHPprQjcamR5CziLkaQLP1cWjE7kpyOk68GGV5Ww7B0Dc
 9Qe2wMQgSkUjT+incDtZEbJmuSg50N4CO+2gwRYTUZy+6MMqPm35uQ8g6XgjXkgIB6Xs2O
 AT4mnJbAhFmxT5uyNPFqvuVAqwvIcnQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607469860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/H1enNHQxNS8h9E+mm8W+uBp7Qvj7G13FO1FCnQAIBs=;
 b=ZKSdAx+wAu3Wbq7o2MpyptColUHPprQjcamR5CziLkaQLP1cWjE7kpyOk68GGV5Ww7B0Dc
 9Qe2wMQgSkUjT+incDtZEbJmuSg50N4CO+2gwRYTUZy+6MMqPm35uQ8g6XgjXkgIB6Xs2O
 AT4mnJbAhFmxT5uyNPFqvuVAqwvIcnQ=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177--yQswzidMXeH-8emsDQOGw-1; Tue, 08 Dec 2020 18:24:18 -0500
X-MC-Unique: -yQswzidMXeH-8emsDQOGw-1
Received: by mail-pf1-f197.google.com with SMTP id e126so331242pfh.15
 for <linux-erofs@lists.ozlabs.org>; Tue, 08 Dec 2020 15:24:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=/H1enNHQxNS8h9E+mm8W+uBp7Qvj7G13FO1FCnQAIBs=;
 b=lDmo5tZuawdhB7Jq4r8dTcfJu4rKG2JgT1Yp4CtnMm+HSFvIsdI8GYXi8euzeQbNbR
 Dj+EssjlQR6uYPhJfZnjcWS1iAz4d+vBLQu2+ze5Zbpt8Yn3gha/qnCbz5cRVb/lhwb0
 pz1idgvXwzYk5PCUWTh4vokZv9TDxRHLFoMKNOPOlDYYCV3Wz8syZD6Rdu7K1ArO3wX9
 nJk5XDSh1lEH1Sq3rn6KHfK1bzw1VB3BCLo80AKo9EAYrwGs/huDg3JkT1lILpykVaMJ
 nvr2Y+HgzByHCRSi6IERi352/KuF7eQTBorSD3QIjLzi3OGs2BsPX9yqXif4XwiZxnji
 8Lug==
X-Gm-Message-State: AOAM5303sDG8YpyYFC2oP6zQiD7H72kTh2IYN9Xx+GDQTI984OkXkUoG
 QmwK7s3rjsRvTYg+rUh+G08npQ6eyvWPCNwTwfzZWbZLIV0PPWFRvxv4eIMaeEC8rDaHjI5yV2g
 38wvJauXYQRMYnfjMdvtZ78L5
X-Received: by 2002:a17:902:a3ca:b029:da:df3c:91c8 with SMTP id
 q10-20020a170902a3cab02900dadf3c91c8mr259138plb.41.1607469857829; 
 Tue, 08 Dec 2020 15:24:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwHiS8wOEczEzWKHIQ+86XpORx038Yv0j1jWVYrfem8BPiBn7P5jwqTBM3YDpugbYtly0ng2g==
X-Received: by 2002:a17:902:a3ca:b029:da:df3c:91c8 with SMTP id
 q10-20020a170902a3cab02900dadf3c91c8mr259129plb.41.1607469857616; 
 Tue, 08 Dec 2020 15:24:17 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 193sm265371pfz.36.2020.12.08.15.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 15:24:17 -0800 (PST)
Date: Wed, 9 Dec 2020 07:24:07 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: nl6720 <nl6720@gmail.com>
Subject: Re: [PATCH] erofs-utils: fix multiple definition of `sbi'
Message-ID: <20201208232407.GA3257594@xiangao.remote.csb>
References: <20201208105741.9614-1-hsiangkao.ref@aol.com>
 <20201208105741.9614-1-hsiangkao@aol.com>
 <29768659.UDeB2voVRW@walnut>
MIME-Version: 1.0
In-Reply-To: <29768659.UDeB2voVRW@walnut>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Dec 08, 2020 at 06:16:57PM +0200, nl6720 wrote:
> On Tuesday, 8 December 2020 12:57:41 EET Gao Xiang wrote:
> > As nl6720 reported [1], lib/inode.o (mkfs) and lib/super.o (erofsfuse)
> > could be compiled together by some options. Fix it now.
> > 
> > [1] https://lore.kernel.org/r/10789285.Na0ui7I3VY@walnut
> > Reported-by: nl6720 <nl6720@gmail.com>
> > Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> > ---
> > Hi nl6720,
> > could you verify this patch? Thanks in advance!
> > 
> > Thanks,
> > Gao Xiang
> 
> This patch fixes the build issue for me. Thanks!

Thanks for verification, I'll push out this later...

Fixes: 5e35b75ad499 ("erofs-utils: introduce fuse implementation")

Thanks,
Gao Xiang

> 
> 
> 

