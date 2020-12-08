Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2092D2D2904
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 11:36:12 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CqxRY1y5jzDqY2
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 21:36:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=FDo+4ewZ; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FDo+4ewZ; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CqxRG4X5xzDqGn
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Dec 2020 21:35:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607423750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XLaPgrslu1QG7gwYF7LzvnzPEl7alt7MxFbFNamqP+w=;
 b=FDo+4ewZwL2VHR/13eO/L8BaHJ1Vgw5/wxKJ6kwhJKwCITJzWlsAJ13Ujal+1iGTlW+BQJ
 5QygmZuwci2CBINemwYVM7eMkJDb/dbNeu72AkK0O/Qi3FcO349GwDAwc+qEorHgmamB6p
 okXnzz++YROpBi614OCqFUy48SNbHqA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607423750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XLaPgrslu1QG7gwYF7LzvnzPEl7alt7MxFbFNamqP+w=;
 b=FDo+4ewZwL2VHR/13eO/L8BaHJ1Vgw5/wxKJ6kwhJKwCITJzWlsAJ13Ujal+1iGTlW+BQJ
 5QygmZuwci2CBINemwYVM7eMkJDb/dbNeu72AkK0O/Qi3FcO349GwDAwc+qEorHgmamB6p
 okXnzz++YROpBi614OCqFUy48SNbHqA=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-qlNDgwg5PEmkmBzAW4oYSQ-1; Tue, 08 Dec 2020 05:35:48 -0500
X-MC-Unique: qlNDgwg5PEmkmBzAW4oYSQ-1
Received: by mail-pf1-f198.google.com with SMTP id x26so12306918pfo.23
 for <linux-erofs@lists.ozlabs.org>; Tue, 08 Dec 2020 02:35:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=XLaPgrslu1QG7gwYF7LzvnzPEl7alt7MxFbFNamqP+w=;
 b=DsJMqHIiaLdKKx+qpADPs7qR7ibMKX+/lEVChHbb+nNpbKkgFKMLr/iVAzE4Ew1+1V
 wKsG4TjkcZ4MjmJi6HGn3sDjzF8PHSh7Y6TX8QkMpYBPX1FLlFZ6abwybDjxyumc6CcG
 K+hL371GD8zi7a6aEZ8xuGEoF8J6188FdrL2CiuoZwJKnyrRPC8Y11QBwBiGzVhpZVHo
 tLmy5DrU0VzEV+aY1rMGdV9LV/AhQI8f6oBQBWtykNaM6X6ij+qWjW0iVL7UWoNBRKVA
 U9WgzDNmbXQLGvaPhFIQwOD7jz2anAIVwi/Rj03tnmMQh5ndrQSueB76waH0S5r2ZAOL
 wIyQ==
X-Gm-Message-State: AOAM532A9p0F6g/YXukMcDT/fWcaZAVkitCw6KkzKY3D5BOqYaOtleF1
 Iymwi7cfkIwBAcdMfDavWgz21DdwIEsDwEsswSJzE8IHlUyrq7OUl9nkabWbf7Qszte9aYXpEfa
 9/vFpWa7nfPLeo/TC8GJv2e2h
X-Received: by 2002:a17:90a:fcc:: with SMTP id
 70mr3600204pjz.168.1607423747383; 
 Tue, 08 Dec 2020 02:35:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJztDBlr72XiF9Ilx9JCyhIn71Da4bqc6vk4bMvLO3rwF29VJWxEarI/ux32I+n917OG7sm3QA==
X-Received: by 2002:a17:90a:fcc:: with SMTP id
 70mr3600186pjz.168.1607423747159; 
 Tue, 08 Dec 2020 02:35:47 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id f92sm2855575pjk.54.2020.12.08.02.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 02:35:46 -0800 (PST)
Date: Tue, 8 Dec 2020 18:35:35 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH v2] erofs: fix wrong address in erofs_get_block
Message-ID: <20201208103535.GA3139231@xiangao.remote.csb>
References: <20201208093133.5865-1-huangjianan@oppo.com>
 <9fb238a9-ad1e-cf7b-7b42-291e5f0e8929@huawei.com>
MIME-Version: 1.0
In-Reply-To: <9fb238a9-ad1e-cf7b-7b42-291e5f0e8929@huawei.com>
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
Cc: zhangshiming@oppo.com, linux-erofs@lists.ozlabs.org, guoweichao@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Dec 08, 2020 at 05:48:10PM +0800, Chao Yu wrote:
> On 2020/12/8 17:31, Huang Jianan wrote:
> > iblock indicates the number of i_blkbits-sized blocks rather than
> > sectors, fix it.
> > 
> > If the data has a disk mapping, map_bh should be used to read the
> > correct data from the device.
> 
> Thanks for the fix, I was misled by sector_t type...
> 
> What about avoiding using generic_block_bmap() which uses buffer_head
> structure, it limits mapped size to 32-bits:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test&id=b876f4c94c3d1688edea021d45a528571499e0b9

Also a minor thing is to Cc: LKML <linux-kernel@vger.kernel.org>
in the next version and for all kernel patches, which is needed
for upstreaming.

(quite closing to merging window...)

Thanks,
Gao Xiang

> 
> Thanks,

