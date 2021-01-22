Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F0B300401
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 14:21:52 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DMfzs4XPQzDqF5
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Jan 2021 00:21:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=FmKEv5yN; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FmKEv5yN; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DMfzh0zRnzDqbW
 for <linux-erofs@lists.ozlabs.org>; Sat, 23 Jan 2021 00:21:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611321692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hskj6fdwMqK47292+tv35UQvs1TScwQ91T333lXrURQ=;
 b=FmKEv5yNVpVIwm4r2TaTTD+uu7EB53MWoRa8bDQs0n4i2zrT/KcdfbcF/AlBgJsuSyJ8Os
 d3B9aTYZn53e8piuKTaDYiXSJ19i8WL472YG0Sh0Tpj4TckSvlqChzq0P1ClbOsMeSgVgt
 1l0728ZLoV7WT9Ry1XcNFWzxdrxAcBI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611321692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hskj6fdwMqK47292+tv35UQvs1TScwQ91T333lXrURQ=;
 b=FmKEv5yNVpVIwm4r2TaTTD+uu7EB53MWoRa8bDQs0n4i2zrT/KcdfbcF/AlBgJsuSyJ8Os
 d3B9aTYZn53e8piuKTaDYiXSJ19i8WL472YG0Sh0Tpj4TckSvlqChzq0P1ClbOsMeSgVgt
 1l0728ZLoV7WT9Ry1XcNFWzxdrxAcBI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-qVwaobRCPkK6NIXImLcI5w-1; Fri, 22 Jan 2021 08:21:30 -0500
X-MC-Unique: qVwaobRCPkK6NIXImLcI5w-1
Received: by mail-pf1-f200.google.com with SMTP id 137so3365574pfw.4
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jan 2021 05:21:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=hskj6fdwMqK47292+tv35UQvs1TScwQ91T333lXrURQ=;
 b=AOqK7LSHLsPcMs8PuOFCmHE+2405gwtMP+KpiKtY3rCwDBa20Z2OeXO5sBWfY6GiF3
 6zJt6V5dm81EKJOFuHZPbS5xLUcXxhvmMXzPTsEppHoTc6ubMCQ9IF9qC1/k3YP/C+uo
 OdATU7dyS68qIThOEfQi64SVMU2edw+eUAsLz/AI69bOFGkrBaSF0SoMpucUjnZxiFdQ
 MfLnoGlyHb+KHOOA4Pe2WW115dcJXUalsfXpalZghtzDAs9JPf71vL32DHvuRO4SR6lm
 UPOfh13Vfljtavv7ojnRv/DRBw1GHlSOT7J3+BqJB4VbuTcKMc8yso57zcWq4NfvqAps
 +pVg==
X-Gm-Message-State: AOAM533fZ7wqH9TDPLTSomjXL4aWAwMOXjraRSqvebKEhcbrSIkCG7c+
 tYwAaX+E9CHJ8gHw3YbSbgCl5XcKDO+8w9Cz5ILdquuLcT3Uvuc/xehj5HHpHqjejsaiD95+Ps9
 mDhV7a+HWFk8fOvWsl7nzle6A
X-Received: by 2002:a63:ff09:: with SMTP id k9mr4666847pgi.175.1611321688977; 
 Fri, 22 Jan 2021 05:21:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwVldgJd37GqPeoS4c2C/RQuMKZxvjwQ0tz3CCMZCHoSOVnJ3/ok06tpnOUsZqOuIe42JIbbg==
X-Received: by 2002:a63:ff09:: with SMTP id k9mr4666825pgi.175.1611321688695; 
 Fri, 22 Jan 2021 05:21:28 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id w20sm9843994pga.90.2021.01.22.05.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Jan 2021 05:21:28 -0800 (PST)
Date: Fri, 22 Jan 2021 21:21:18 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Hu Weiwen <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH v6 2/2] erofs-utils: optimize buffer allocation logic
Message-ID: <20210122132118.GC3105292@xiangao.remote.csb>
References: <20210116063106.5031-1-hsiangkao@aol.com>
 <20210119054951.7457-1-sehuww@mail.scut.edu.cn>
 <20210122131408.GB3105292@xiangao.remote.csb>
MIME-Version: 1.0
In-Reply-To: <20210122131408.GB3105292@xiangao.remote.csb>
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

On Fri, Jan 22, 2021 at 09:14:08PM +0800, Gao Xiang wrote:
> Hi Weiwen,
> 
> On Tue, Jan 19, 2021 at 01:49:51PM +0800, Hu Weiwen wrote:
> 
> ...
> 
> >  	bb = NULL;
> > 
> > -	list_for_each_entry(cur, &blkh.list, list) {
> > -		unsigned int used_before, used;
> > +	if (!used0 || alignsize == EROFS_BLKSIZ)
> > +		goto alloc;
> > +
> > +	/* try to find a most-fit mapped buffer block first */
> > +	used_before = EROFS_BLKSIZ -
> > +		round_up(size + required_ext + inline_ext, alignsize);
> 
> Honestly, after seen above I feel I'm not good at math now
> since I smell somewhat strange of this, apart from the pending
> patch you raised [1], the algebra is
> 
> /* since all buffers should be aligned with alignsize */
> erofs_off_t alignedoffset = roundup(used_before, alignsize);
> 
> and (alignedoffset + size + required_ext + inline_ext <= EROFS_BLKSIZ)
> 
> and why it can be equal to
> used_before = EROFS_BLKSIZ - round_up(size + required_ext + inline_ext, alignsize);
> 
> Could you explain this in detail if possible? for example,
> size = 3
> inline_ext = 62
> alignsize = 32
> 
> so 4096 - roundup(3 + 62, 32) = 4096 - 96 = 4000
> but, the real used_before can be even started at 4032, since
> alignedoffset = roundup(4032, 32) = 4032
> 4032 + 62 = 4094 <= EROFS_BLKSIZ.
> 
> Am I stll missing something?
> 

Oh, the example itself is wrong, yet I still feel no good at
this formula, e.g I'm not sure if it works for alignsize which
cannot be divided by EROFS_BLKSIZ (although currently alignsize =
4 or 32)

Thanks,
Gao Xiang

> IMO, I don't want too hard on such math, I'd like to just use
> used_before = EROFS_BLKSIZ - (size + required_ext + inline_ext);
> and simply skip the bb if __erofs_battach is fail (as I said before,
> the internal __erofs_battach can be changed, and I don't want to
> imply that always succeed.)
> 
> If you also agree that, I'll send out a revised version along
> with a cleanup patch to clean up erofs_balloc() as well, which
> is more complicated than before.
> 
> [1] https://lore.kernel.org/r/20210121162606.8168-1-sehuww@mail.scut.edu.cn/
> 
> Thanks,
> Gao Xiang
> 

