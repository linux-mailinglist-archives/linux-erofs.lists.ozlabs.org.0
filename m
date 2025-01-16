Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F74A13236
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 06:04:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1737003840;
	bh=RQtwcz66cRpnEOfOa/HyiuZRqWSGLaKRKp3+zlxh6e0=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ZC6pFKKPZKX9MEzRKiOqNxDdeKYBpKCo6fA73h1n/8UINTQ9Kb9lNqdF1GDngRaJT
	 qYn/fE3IdmzdldUWOrbtUSr47QBE87i9eRAcHlVZB2CC3jAdmSSKRYJGhDHHC5vjaw
	 gN1LyVo6IKcEtZOObMCTf8CqyMVMaOOe/x0ffO+qCwsP0OwGsjxtgzygQgPu2ZHRUG
	 xRLn4ZiyWl//ptoQiTA7ezg3xD16hp5+b23P9hGtdv/AiHu6mtmQlqWqBI8pwA7hyQ
	 P2MwGURdQvwQ6bFFVyxkm2UIxAILrU5ueB/WB3oocThOc1zO6wOGMavLNA6tv6kETB
	 BRstongfSG4jw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYW404HQ2z3bjs
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 16:04:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737003839;
	cv=none; b=OAG/wwxwEuyjRj0CPdHMPMVevprdCG+OT10ilAn3CYRBNkNoxBgAIhk23fTiOqEdfMqHYhiGfktqRSS54W6/Zo9QuMHh7kXBYD8iwsdssEt4OtQt7jvjg/Am5LojQmJq+y5MqV3r6oI6QzE9ZtuxJJVhjlt6xDPBiLLguT05tz9dGg/S6qEXRRw2+OYEGZQx+tyb7v0gP2TgYO9nkMvHqQ+WYZBinZU3qYSGHD/GtB2q8hh5IPH+4CkJzkja6nxCD4RQhCTAFtX1luxDYUkItWa8GaRaR4egtbYZRNTNjl4CkP7J14aUCJxeeclc0pGJmvujRn52raaiuhQVXQnK2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737003839; c=relaxed/relaxed;
	bh=RQtwcz66cRpnEOfOa/HyiuZRqWSGLaKRKp3+zlxh6e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4eIuFgkFETUONjVBR+N8iOoRE7X0obZD2TDp105u/I4VloZEhSUc6oFzNM7y5Q7k3mVL30pAdDSEldti0uWH2KqXSBkG2gXI1LRPwDgMridpLmw06w23pNncFKhnDEZ9ehKQ92qh7BIVmtdgX0rj05OdVNL+d6KHZFft06Z21mtteHfrL4MLH7enUUths4IwqhvD3XvOH+v3XMkYtaQL4GZezwxWs3EMkAM6Uj1oZiA5gJFv/K9/+JFbIsdiNMGvjxJvGLb3RO96ycUL6JF0yGeEqrAfHp7mb8z4kZmp0IixtDnlcy5xLBd2gD4p0hdL7Vm3L1iF7/W70e38iZ3Zw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; dkim=pass (2048-bit key; unprotected) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=cISSF9CR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=david@fromorbit.com; receiver=lists.ozlabs.org) smtp.mailfrom=fromorbit.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=cISSF9CR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=fromorbit.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=david@fromorbit.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYW3x6nGdz2ytm
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Jan 2025 16:03:56 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2164b1f05caso7846885ad.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 15 Jan 2025 21:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1737003835; x=1737608635; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RQtwcz66cRpnEOfOa/HyiuZRqWSGLaKRKp3+zlxh6e0=;
        b=cISSF9CRLWMocUTmvpV8yK3PfYugv5L512OL99mrmJkzFihhWV7ulD7u4lieL7wICm
         OSm56OzxjIJWeFZKpFF8NrDmnIGBPkHs+mD74uVV4FGd0ce+kCtSp1iRlAG6heGCTLN9
         d5NHsCYOt2ZyxgOZQ7w6/QNh76zt1zOHBmNj8F3qqkzE1N7qu7UddttQEWHdnslkL0M1
         DCvJ1JYSTLXlde6YMfjVURn2czlnRYyUq79bpUFrT3tuQa2MGBH1NGzZ0g8yz17dUm15
         PY1teXVK7KBmZQkXtXP3oIxqQUESr75BP+ygjwJerV3PTfOq+BCntjKpTqvYUILfHIGJ
         K5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737003835; x=1737608635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQtwcz66cRpnEOfOa/HyiuZRqWSGLaKRKp3+zlxh6e0=;
        b=C1oozf+xWoxxSjsPh2wpl+Y002PqnsMJjuuUpCoWBLBkty2yG9xeQ3PYxzx5QawEHx
         +LeL6oTx/Dw8QqmYOHezuU4KSPko9/3dyJDAMz7yjkRGjdffW6OBFrjiWXCdYFmcevxP
         HeJHb3ToX3N7j43mamwxCWsXp/n+UxQ8b5r8d+oEtpyHZL5HhdF/yOS/9HkljCZFwi4j
         nCxSZtx5YgXkRCEUU5R41wh6UsLyHcfHWMCeDdPyiHHgo30d8KPxwCP6a3bHUAlQzTnO
         CWbfoCTAt9UoeB5wFhClNq6of0qozIEPwJ7KI1spyKjTj7asDCOv3fVbUTdLYKXx7hRc
         ZK3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWosquCQdlb3DVqPF0U7F2JlW2s7gFUrLaz7IgESaTBfEWOs09kBGTjuObRukEym8nLRoqqe3ko56ELzQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx2G9IkZ4ECfNgOYCvmk0MBMUgltfRpmp8NH1wcQuRGIgVngQe2
	z4ZR1xRhbUytCOT6qTvgxqBTnC5BHBYHGefC2eBqmrvVKPv3qkhJA8PJ4MNPYkw=
X-Gm-Gg: ASbGncuzW1PMTwetoCoq+qqotomuDdlWHAygCD4Z9hfQHdxZTPZkhY2BFOJW9g6J64Z
	hlQ44euqqCk0QGEPRn/EGaloUIqMEwXk8H5AQM0g0Hmu/iOGN4zTcMsfbzteIi1vYx04bBOjaXw
	n2+VAc9NQq1flrms2bWQu7aomx5ifp4z6agJCKL0kA8ljMgrlkwvG5n0EstcZTID59fX9TJTzhQ
	b6dPw70SEAPdx3cpJrn0LC438lqhMRMG+7uIbgu64hknr03mGO+R36KYjN5YN0ERsdCpyB8L3U2
	XSUx32v8Q/PanhuUIOKDnFTlTUwY/ixp
X-Google-Smtp-Source: AGHT+IGNOhZ2CDB3dC9ypPRx2+QFrztyTh30xO+H1dvtRXfxPIdj2LE0KDNO2Mwf1ivGr5YrWG2u9A==
X-Received: by 2002:a05:6a20:244d:b0:1d9:fbc:457c with SMTP id adf61e73a8af0-1e88d0a4771mr34957994637.36.1737003834927;
        Wed, 15 Jan 2025 21:03:54 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4067f72dsm10406495b3a.145.2025.01.15.21.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 21:03:54 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tYI2p-00000006SjT-2V99;
	Thu, 16 Jan 2025 16:03:51 +1100
Date: Thu, 16 Jan 2025 16:03:51 +1100
To: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 6/8] dcache: use lockref_init for d_lockref
Message-ID: <Z4iTN86x2SsTVOIY@dread.disaster.area>
References: <20250115094702.504610-1-hch@lst.de>
 <20250115094702.504610-7-hch@lst.de>
 <Z4gW4wFx__n6fu0e@dread.disaster.area>
 <20250115203024.GB1977892@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115203024.GB1977892@ZenIV>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: Dave Chinner via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Dave Chinner <david@fromorbit.com>
Cc: Christian Brauner <brauner@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Jan 15, 2025 at 08:30:24PM +0000, Al Viro wrote:
> On Thu, Jan 16, 2025 at 07:13:23AM +1100, Dave Chinner wrote:
> > On Wed, Jan 15, 2025 at 10:46:42AM +0100, Christoph Hellwig wrote:
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  fs/dcache.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/dcache.c b/fs/dcache.c
> > > index b4d5e9e1e43d..1a01d7a6a7a9 100644
> > > --- a/fs/dcache.c
> > > +++ b/fs/dcache.c
> > > @@ -1681,9 +1681,8 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
> > >  	/* Make sure we always see the terminating NUL character */
> > >  	smp_store_release(&dentry->d_name.name, dname); /* ^^^ */
> > >  
> > > -	dentry->d_lockref.count = 1;
> > >  	dentry->d_flags = 0;
> > > -	spin_lock_init(&dentry->d_lock);
> > 
> > Looks wrong -  dentry->d_lock is not part of dentry->d_lockref...
> 
> include/linux/dcache.h:80:#define d_lock  d_lockref.lock

Ah, I missed that subtlety (obviously). Carry on!

-Dave.
-- 
Dave Chinner
david@fromorbit.com
