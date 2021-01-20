Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C53962FCA5F
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Jan 2021 06:14:13 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DLDGB4DNpzDqCx
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Jan 2021 16:14:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=UtC36Ovh; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VBGLQft6; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DLDDQ6kn2zDqxX
 for <linux-erofs@lists.ozlabs.org>; Wed, 20 Jan 2021 16:12:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611119551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K75M7ak3Mlq4vpGhgNlJry31dW7pTxbCVCNMOY71fxQ=;
 b=UtC36OvhGweE+OrmyviB1DTIpc0NKjt9A5g8oc9ewQvZLKDeB2HZxHpCMo4t204ubnGm+b
 2jjA3V+0vVvj2B9uoxsLxZKN7XsznH0Z9EKeGJ9tjWlhBzXJnMjG9CPLWBPZEIyr4d+3D4
 8Ke+mG2ojyUTtgaxPvoKuMOYjA3i0Fc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611119552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K75M7ak3Mlq4vpGhgNlJry31dW7pTxbCVCNMOY71fxQ=;
 b=VBGLQft6rIy1RW6dmlPj8EQ8+Ay7hGTYqeAgUjuANm1JPRTLy0URKrjwoVpKF1LwU6JuC+
 ZddG8S5Im9Gg0V16imPTvnxU/KWtNWNpWwiD/nrj0uERpo/O3GgC6Bkc/sv1z+8NrPizXX
 KpK08IhKV7QN5zOhhvWfXUvcQuihSQk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-9UZIOB3SNJyQ1CoybBymfw-1; Wed, 20 Jan 2021 00:12:28 -0500
X-MC-Unique: 9UZIOB3SNJyQ1CoybBymfw-1
Received: by mail-pj1-f72.google.com with SMTP id v14so1837275pjt.5
 for <linux-erofs@lists.ozlabs.org>; Tue, 19 Jan 2021 21:12:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=K75M7ak3Mlq4vpGhgNlJry31dW7pTxbCVCNMOY71fxQ=;
 b=QFG00/Et1u55Gj9+Ihq7ND698WA0Do5xh3uDDvphLzsicT7l43rGpAQrW2CjBhY6i7
 CoUtXlHzh/SblH7kQwX8BfBeSTYKdBZdYbK6wR7sn2OZ435v3IVkwqOr/E0qvk9f+SYS
 ZI4yrkcn/RXBSz07nbvCEGxfhxAl4Iij3AEQklGL9mcae+TnkYJpLRynBKqPfpQ5AZ9e
 Zlx86vIWH2ZDnJE0jTSe81M+6nx7k5Kiybz2VHaB4jpbh8ETHDL/SvxAMU2uN2FxWINY
 7jjYHYA9+XD2MjMAHD4mnfj8RLJpGD95vF4N2VupNm+uQQjPoj9h/UPE4intkKjPoFqs
 tDCQ==
X-Gm-Message-State: AOAM532AjBCVeSJhnYzvTU+aEr/Yn/iY9gJzmIm96xd+y/ReumY4i19i
 /v/02O7KMnA3M5N2LN5GvGkvZPPVfIaYrE4cR1mcwnpKaUCEKqyufbat5thGkM71vI2bed5R3Li
 LhDYw3O2lLoa9IDG+5cBbsjXZ
X-Received: by 2002:a63:f013:: with SMTP id k19mr7641578pgh.151.1611119546907; 
 Tue, 19 Jan 2021 21:12:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJydfu0+dpAWIWNQXmMzXNKuaSzSFVLc+ZJXbxk9ldW8mZkj655TPHkPWLZdmEs7EIAEr+sGRQ==
X-Received: by 2002:a63:f013:: with SMTP id k19mr7641564pgh.151.1611119546598; 
 Tue, 19 Jan 2021 21:12:26 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 72sm748455pfw.170.2021.01.19.21.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Jan 2021 21:12:26 -0800 (PST)
Date: Wed, 20 Jan 2021 13:12:16 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: =?utf-8?B?6IOh546u5paH?= <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH] erofs-utils: fix battach on full buffer block
Message-ID: <20210120051216.GA2688693@xiangao.remote.csb>
References: <20210119154335.GB2601261@xiangao.remote.csb>
 <32A61DA5-EED5-4268-B6C5-CAAB94527F91@mail.scut.edu.cn>
MIME-Version: 1.0
In-Reply-To: <32A61DA5-EED5-4268-B6C5-CAAB94527F91@mail.scut.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

Hi Weiwen,

On Wed, Jan 20, 2021 at 12:57:39PM +0800, 胡玮文 wrote:
> 
> > 在 2021年1月19日，23:43，Gao Xiang <hsiangkao@redhat.com> 写道：
> > 
> > ﻿Hi Weiwen,
> > 
> >> On Tue, Jan 19, 2021 at 02:02:56PM +0800, 胡玮文 wrote:
> >> Hi Xiang,
> >> 
> >> After further investgate, this bug will not reveal in any released version of
> >> mkfs.erofs. Previous patch v5 [1] will map all allocated bb when erofs_mapbh()
> >> is called on an already mapped bb, which triggers this bug. before that patch,
> >> under the same condition, __erofs_battach() will only be called on bb which is
> >> not mapped, thus no need to update `tail_blkaddr'.
> > 
> > Good to know this, thanks! I haven't looked into that (I will test it this
> > weekend.) IMO, although this is not a regression, yet it seems it's potential
> > harmful if we didn't notice this... So I think a proper testcase is still
> > useful to look after this... If you have extra time, could you help on it?
> 
> Hi Xiang,
> 
> I’m working on this. I have written a test case for this. And I’m also working on setting up GitHub actions to run tests automatically. So far, I’ve got uncompressed tests works, but when lz4 is enable, all test (except 001) fail. I have not found out why. You may see my progress at https://github.com/huww98/erofs-utils/tree/experimental-tests. I will send patches once everything is sorted out.

It would be better to know which kernel version github action is used (at least
it seems no good if version is < 5.4)? also could you confirm the lz4 version
as well (lz4-1.9.3)? if erofsfuse is used, specify "FSTYP=erofsfuse make check"
to test it.

The temporary results are in "tests/results/", could you also check and debug
it? (please kindly confirm the testcases work well on your local computer,
since such testcase is still WIP, I'm not sure if it has some running issues
as well)

> 
> > Also, without the detail of this, I think the fix might be folded into
> > the original patchset (could you resend it?). In addition, I think after
> 
> You mean add a new commit [PATCH v6 3/3], or merge it into [PATCH v7 2/2]? I send it as a separate patch set because it may be merged independent of the cache.c optimization.

Resend v7 and fold it into [v7 2/2] would be better...

> 
> > last_mapped_block is introduced, we might not need tail_blkaddr anymore,
> > not sure. But I'm very cautious about this in case of introducing any
> > new regression...
> 
> I think we still need it, because already mapped bb may be dropped, last_map_block does not always reflect tail_blkaddr.

Okay, that makes sense...

Thanks,
Gao Xiang

> 
> Hu Weiwen
> 
> > Thanks,
> > Gao Xiang
> > 
> >> 
> >> [1]: https://lore.kernel.org/linux-erofs/20210118123431.22533-1-sehuww@mail.scut.edu.cn/
> >> 
> >> Hu Weiwen
> >> 

