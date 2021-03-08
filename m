Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCAC330638
	for <lists+linux-erofs@lfdr.de>; Mon,  8 Mar 2021 04:02:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dv36b5Xs5z3cKY
	for <lists+linux-erofs@lfdr.de>; Mon,  8 Mar 2021 14:02:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BG+aB+vj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BG+aB+vj;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=BG+aB+vj; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BG+aB+vj; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dv36Y2CVYz30Qw
 for <linux-erofs@lists.ozlabs.org>; Mon,  8 Mar 2021 14:02:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615172545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+f97h3r5kgP8oOoYOWrOrmtPiqRhgTUDjoTBiNYsJB4=;
 b=BG+aB+vjUaz6NtEIutWPOMD0TY/RG96Cq4J4a/DPd+pJPmM2Asv5GFrkZxB304XngiFVHm
 nuNthMDso0opxROCmtNM1VYWimyCAV8d5X4PxkMFxP5Y370WuXXjbo/WYvxyFSrABUQRv3
 Ikb5Cs5dB+OD9fgVOkt4nlC7YxWWH2s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615172545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+f97h3r5kgP8oOoYOWrOrmtPiqRhgTUDjoTBiNYsJB4=;
 b=BG+aB+vjUaz6NtEIutWPOMD0TY/RG96Cq4J4a/DPd+pJPmM2Asv5GFrkZxB304XngiFVHm
 nuNthMDso0opxROCmtNM1VYWimyCAV8d5X4PxkMFxP5Y370WuXXjbo/WYvxyFSrABUQRv3
 Ikb5Cs5dB+OD9fgVOkt4nlC7YxWWH2s=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-EhCfhmojOt29TPnn43UpOQ-1; Sun, 07 Mar 2021 22:01:15 -0500
X-MC-Unique: EhCfhmojOt29TPnn43UpOQ-1
Received: by mail-pl1-f198.google.com with SMTP id n5so3752125plp.7
 for <linux-erofs@lists.ozlabs.org>; Sun, 07 Mar 2021 19:01:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=+f97h3r5kgP8oOoYOWrOrmtPiqRhgTUDjoTBiNYsJB4=;
 b=d7Mx5NHI3MQ2gQu/72WZiW6jXqjRDvt6xqQqnJQY8dVETAFn0RUGNjJMNDRLBr2fRJ
 gIzewAVh/qb7+jrmgLhp6FA6SPrbPbCEPbY65vBTahJ8UPSIbKcJsH9ouKl03sQ84df4
 dk6XMGFo2rpUqNJONE2Uk5zFMKGN2FnNXM6jjaCfyyQ6rdpPLexYt4GcNTe7n4EQqLXV
 VpA9GUiXrM7H1g/vrSCZVMezflse96CMRP9BOue8x2H6F6j1FL/5+bgcqjJZv2VLpkkn
 QJK7EKnJaBPP74+cBGOcv2VIEoSpix/7XzilUo6c43D2ErIOgYIDCrigTvBmtqRgB7Wp
 s/Kg==
X-Gm-Message-State: AOAM533DwGzbvHRJbA5pYcb2XugI4+UrjOPYCcWxPLhGKK73O1lhHKnH
 IEp8z7HmAJvzZwnwtVMGA49HIhU+C0EB3PFs+YsBcjqxclePxecIKR1OhMOywqGoQdJYQwallew
 vEGDADPbCjDodBzjrHJmz0ZrB
X-Received: by 2002:a63:205c:: with SMTP id r28mr19264920pgm.183.1615172474081; 
 Sun, 07 Mar 2021 19:01:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzAaiHHxTjy153gHbNVOfTRCbVDaW1O2b4ItT4xkhJj/ka2w84dyg/Wp5VsMoYm+fNoQXKHTQ==
X-Received: by 2002:a63:205c:: with SMTP id r28mr19264903pgm.183.1615172473806; 
 Sun, 07 Mar 2021 19:01:13 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b10sm8264561pgm.76.2021.03.07.19.01.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Mar 2021 19:01:13 -0800 (PST)
Date: Mon, 8 Mar 2021 11:01:01 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] erofs: fix bio->bi_max_vecs behavior change
Message-ID: <20210308030101.GB3537842@xiangao.remote.csb>
References: <20210306033109.28466-1-hsiangkao@aol.com>
 <20210306040438.8084-1-hsiangkao@aol.com>
 <6525c63c-a6e2-8c39-6c9a-1ca9b54632d8@huawei.com>
 <20210308023650.GA3537842@xiangao.remote.csb>
 <7a96c4f3-128b-6248-b25c-a838ef16a4e5@huawei.com>
MIME-Version: 1.0
In-Reply-To: <7a96c4f3-128b-6248-b25c-a838ef16a4e5@huawei.com>
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

On Mon, Mar 08, 2021 at 10:52:19AM +0800, Chao Yu wrote:
> On 2021/3/8 10:36, Gao Xiang wrote:
> > Hi Chao,
> > 
> > On Mon, Mar 08, 2021 at 09:29:30AM +0800, Chao Yu wrote:
> > > On 2021/3/6 12:04, Gao Xiang wrote:
> > > > From: Gao Xiang <hsiangkao@redhat.com>
> > > > 
> > > > Martin reported an issue that directory read could be hung on the
> > > > latest -rc kernel with some certain image. The root cause is that
> > > > commit baa2c7c97153 ("block: set .bi_max_vecs as actual allocated
> > > > vector number") changes .bi_max_vecs behavior. bio->bi_max_vecs
> > > > is set as actual allocated vector number rather than the requested
> > > > number now.
> > > > 
> > > > Let's avoid using .bi_max_vecs completely instead.
> > > > 
> > > > Reported-by: Martin DEVERA <devik@eaxlabs.cz>
> > > > Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> > > 
> > > Looks good to me, btw, it needs to Cc stable mailing list?
> > > 
> > > Reviewed-by: Chao Yu <yuchao0@huawei.com>
> > > 
> > 
> > Thanks for your review. <= 5.11 kernels are not impacted.
> > For now, this only impacts 5.12-rc due to a bio behavior
> > change (see commit baa2c7c97153). So personally I think
> > just leave as it is is fine.
> 
> Okay, so that's fine if you send pull request before 5.12 formal release. ;)

Yeah, it's an urgent commit and have very negative impact.
I pushed out -fixes branch just now. After leaving in linux-next
for days, will upstream it then asap... :-(

Thanks,
Gao Xiang

> 
> Thanks,
> 
> > 
> > Thanks,
> > Gao Xiang
> > 
> > > Thanks,
> > > 
> > 
> > .
> > 
> 

