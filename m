Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D86462E86DD
	for <lists+linux-erofs@lfdr.de>; Sat,  2 Jan 2021 10:28:24 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D7Glm1Pg4zDqpg
	for <lists+linux-erofs@lfdr.de>; Sat,  2 Jan 2021 20:28:20 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=d/GEzmWy; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=d/GEzmWy; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D7GlZ6XZtzDqBM
 for <linux-erofs@lists.ozlabs.org>; Sat,  2 Jan 2021 20:28:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609579684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tAIK3htBzM6Hy4xN2BeAGJOKtR3EGo2aPGUETqwS5Ew=;
 b=d/GEzmWyKC74gcZ7mcJKu/Tqx73YbeHkoo0+ja9I3aSCmG30pFJVEnsGI8FJgDuB35HcLe
 pAPIyExPNXO0xo0ZqEcymrhl/CzxqtN2Ecl/QJ1Mj6gztjSE3R1LOJlis33kfQ+2nvfHrn
 gtnZRoORMcjrYJneSU4aW0jyo86XEgg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609579684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tAIK3htBzM6Hy4xN2BeAGJOKtR3EGo2aPGUETqwS5Ew=;
 b=d/GEzmWyKC74gcZ7mcJKu/Tqx73YbeHkoo0+ja9I3aSCmG30pFJVEnsGI8FJgDuB35HcLe
 pAPIyExPNXO0xo0ZqEcymrhl/CzxqtN2Ecl/QJ1Mj6gztjSE3R1LOJlis33kfQ+2nvfHrn
 gtnZRoORMcjrYJneSU4aW0jyo86XEgg=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-thMvEw89Ni6adEIa_wnc_Q-1; Sat, 02 Jan 2021 04:28:02 -0500
X-MC-Unique: thMvEw89Ni6adEIa_wnc_Q-1
Received: by mail-pg1-f198.google.com with SMTP id 1so17253156pgu.17
 for <linux-erofs@lists.ozlabs.org>; Sat, 02 Jan 2021 01:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=tAIK3htBzM6Hy4xN2BeAGJOKtR3EGo2aPGUETqwS5Ew=;
 b=MKng5EVtBQsnawcH+KajDq8+30HWb4s8dCxMrQnF1Wa3Crg9imOEKsPiHZpFnW1AWU
 ju7OpLXYk/sOZsIsf0nmuUCVsAEaXIFWmPXhUhCD0wnUNUzsf6inZ/iw2egCNug7deB5
 JnMd+8fA/ttoseipPyfe1CtXET1ba99exT3oROUQlAHJ6EtlFilFWl0clJ+X5khBOfUc
 MByZIvWrYEUCjbJFclkXZHxSwNYOWUUBQ0McDsuAz8eKiMP6iM8f4XHpDkqfLDx2/yD8
 exjKqbSMTWtKqhoTe4i7VlPLlWTbbeXqlSTD3cJecExpaOZHLfPW6XO7/zVijFU6Fv5N
 cstQ==
X-Gm-Message-State: AOAM533MAIjpnEPrKv+i3TNNTfZzpYWSq1PelAG12ksr8MY421OVtOsM
 f7oQpYxBmp+eli0ggzY7ZgzQ48naCeTO+tQQC2D2BEvfu1gs1mMkpx59vbGzFLpWo171upyJ6OX
 igMBs1bSpvQhbh1U9RGOtxYgj
X-Received: by 2002:a62:dd94:0:b029:19e:92ec:722a with SMTP id
 w142-20020a62dd940000b029019e92ec722amr59408432pff.50.1609579681150; 
 Sat, 02 Jan 2021 01:28:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxkv6R577NWFOw/usjBkUjVWktw9Od1p9UfKNpuEBQZi9miBMul91YpslkjbPxOfrBkDehGLQ==
X-Received: by 2002:a62:dd94:0:b029:19e:92ec:722a with SMTP id
 w142-20020a62dd940000b029019e92ec722amr59408421pff.50.1609579680876; 
 Sat, 02 Jan 2021 01:28:00 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id u189sm49494558pfb.51.2021.01.02.01.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Jan 2021 01:28:00 -0800 (PST)
Date: Sat, 2 Jan 2021 17:27:50 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: =?utf-8?B?6IOhIOeOruaWhw==?= <huww98@outlook.com>
Subject: Re: [PATCH 2/2] erofs-utils: refactor: remove end argument from
 erofs_mapbh
Message-ID: <20210102092750.GC3732199@xiangao.remote.csb>
References: <20210101091158.13896-1-huww98@outlook.com>
 <ME3P282MB19387A6D70997B82DE981954C0D50@ME3P282MB1938.AUSP282.PROD.OUTLOOK.COM>
 <20210102051459.GB3732199@xiangao.remote.csb>
 <ME3P282MB193853B54A77E4698E4869BEC0D40@ME3P282MB1938.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
In-Reply-To: <ME3P282MB193853B54A77E4698E4869BEC0D40@ME3P282MB1938.AUSP282.PROD.OUTLOOK.COM>
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
Cc: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Jan 02, 2021 at 06:00:06AM +0000, 胡 玮文 wrote:
> Hi Xiang,
> 
> If I understand it correctly, when ‘end == false’, the last buffer block will not get its ‘blkaddr’. I can’t see why we need this, but I might be missing something. And every invocation of this function just pass ‘true’ to this argument. I’m intended to remove some dead code which is never invoked.

Yeah, your understanding is correct. The original purpose when 'end == false' was to
return the start blkaddr of a buffer block in case of (or reserve for) later use (e.g.
get the blkaddr of a inode or some data block that will need). and 'end == true' was
to return the tail blkaddr.... But, I think the behavior of 'end == false' was
completely broken at some time...

> 
> > 在 2021年1月2日，13:15，Gao Xiang <hsiangkao@redhat.com> 写道：
> > 
> > ﻿Hi Weiwen,
> > 
> >> On Fri, Jan 01, 2021 at 05:11:58PM +0800, 胡玮文 wrote:
> >> Signed-off-by: Hu Weiwen <huww98@outlook.com>
> > 
> > It seems that it drops the needed argument `end'.
> > 
> > The original purpose of that is to get the beginning/end blkaddr of a buffer block
> > in preparation for later use, some specific reasons to get rid of it?
> > (also it only drops one extra line considering the diffstat....)
> 
> That’s because I already assumed ‘end == true’ and rewritten this function in [PATCH 1/2]
> 

Ok, let me seek some time read into it :) the complexity issue of buffer allocation
is a known issue and can be optimized by some caching (Although Android don't have
too many files) :)

Thanks,
Gao Xiang

> Thanks for your reply.
> 
> Hu Weiwen
> 
> > 
> > Thanks,
> > Gao Xiang

