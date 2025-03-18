Return-Path: <linux-erofs+bounces-84-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F39BA677B1
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Mar 2025 16:25:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZHFyz2qpGz2yrp;
	Wed, 19 Mar 2025 02:25:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f32"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742311531;
	cv=none; b=nF1433iwHftQjjcSH2yEWWH9pz6ZGfhC+Oc4y0xdxCd2GIvX7XkNlZu8Y0I+fRweyjIbtcviVKJ5eYCIriLmxDZfVSqGywpxSlubN98UwC1VXuT0lt3on7HeLENaBrh6LrFklQXURfi741l1Xk8y9xTKybf6oCXhWs8qzqv5f/PuRUXApdCxTyHvhWnJDGjWKt8Mhlh0CqFxVN0nvCpvRKV6MSi0P2xBK9trqubtQ9vdhfJMBzV3mnSmGPwq33qJYnvCCOFONOsq7bxjwhQiAuz9SSQfK/13U6s57rNePVTUVWAjn5b3/7kb+SZbriYubhh4+hwDScCaj+3Sn4vb7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742311531; c=relaxed/relaxed;
	bh=Iyn8RJjlleD7uhnXI6huIEcPWo+6WvTYSC8J/PV1Ppw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+0ZGmhDhDSZfOoKHgFBD4os5mPEjGJdmKNmP3MgzWG7B5QfNOjvoDQZquu157B9+gfqzUKnUCKB2loHGsw173R/K/RmPv7X9Xp2iN28mDEpeC/kvPlsaNk08MHvJLrZftKJ3D2z3nQwFgn1FBI7GZHSF/oq3R8aaXEazhaN3u2+Zu8tHUlAo3dzfzKEq81uZ5EKq/cX569711FVN4ccSOLQz/KhIfOgLcCzvMmc0b5HfD4L3aObI3eazcdh4QnEHBqiqBPXOONu6VaWV5V/gY10PKQMqQcbUm0y3HNMhFc8hzhGIlyeNFyy9/x+rQhj611IRhDJUohTDiFK94vAXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Nip5FPqx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f32; helo=mail-qv1-xf32.google.com; envelope-from=mjguzik@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Nip5FPqx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f32; helo=mail-qv1-xf32.google.com; envelope-from=mjguzik@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZHFyx570yz2yrn
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Mar 2025 02:25:28 +1100 (AEDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-6eaf1b6ce9aso45335476d6.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 18 Mar 2025 08:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742311526; x=1742916326; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iyn8RJjlleD7uhnXI6huIEcPWo+6WvTYSC8J/PV1Ppw=;
        b=Nip5FPqxw4AWX3WHJIV4ROMDdb1GrvW5+E2z8JRrVaAFD4ipvl6XiyXbrkyRr5PBu/
         +89VhUTx9n73C+ek0G8Gv6BBX46hCozwX43rrYBu7Bu1/FCAUKx0ACKAk5XhuzPiepY6
         O1XLt/GInx+IOUFXBiOmYjhtt3bJiFeMBTE1SJyfVTrzTenvBFuv5remZCZeCSvqZJRO
         oym/PAwnPMkZgKKgLOiRSRKd6vSquDqQtQ3KbQu6wUYrTF4Yojtj7CqR+AELXVJSbuR4
         Y9yC2m2m9nfZEdsAkAztLFXvfY6MB61Q9bXyNP5aImVbpqmXcGlEkEuDG//6KdjZP6PS
         G/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742311526; x=1742916326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iyn8RJjlleD7uhnXI6huIEcPWo+6WvTYSC8J/PV1Ppw=;
        b=Tj7XN2GqPVTWlRCGI5P1l0LZ2vd6j9s9JJQQP0j2yjcdv4swg54N7OSDXMviBNSepC
         +DJ4Ij/X1skq7dmPOToZfsmCrqSjmAfiLevTIQCm1ltr/B8ct3PeYvW34ph4teQYYulC
         Vy1z5l/2Z2TK+G3CRlX/963Hp2hZphTVhqiRRB6d49pwVBaMEdJBUaKeph2+3pnazJ9d
         CQy9E8RuRA1vf+ccIWC38Z7wrxnphT+wqoBMt41J5DTnHO3UrEOV+Z1nvTL9pmySOeCP
         PxEds2Q+z+rvq3H5+vmpVbgJRXJ6+US+aZ0tgpKd5e4lwPxpBrEcoJXYx+wcfGjCFsZo
         CITw==
X-Forwarded-Encrypted: i=1; AJvYcCU6HZpreU4a137T0m9qPsK60x7u5y5UVzW6RbELTe7j9MyihHstudHl5js6LJZq2wYjrh/0OyuL26pmiw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy1QPOnHdhM6fFXxBg4Qh4vd2xRgUkbLhoRZtzEm+6P2MFIYtKb
	Ur7owrBHwg5k0JZr29dfuz01MCHvX7F+uoNCWnTNQQlqKmuAuj2c
X-Gm-Gg: ASbGncvoPNump0Kerapy/xdOKPwEcKOOpzeHcFDCg7rc+V/i6KFXy3PSMNHBQHQCP3W
	CqwpnleR2B1xoBJwlQxzsmMRqkTPBaQqaBaX3heYsuIxLtFItjOsyI/wsSAij8N8ui7fyNiR1Bl
	Sg6rAAylx7ntfHfBMAZunSUsbkGbNcMenqsQqdAvTY0mfk99bg98W9hYAYhBQT3c8qpB1IRbOPb
	u0fv6QGM++XljXJKcYa3Yp+KVp/9fFc/xb5EhpJHe5DkqQ8c0OjE8WGz3JRmHB/O9N0e3UJU3h2
	QAFMaLpBULxXCtoH/DkDagP/oNG0jCZGnp831UYSV+Y1EwHGwBG7Dm28r9qZ
X-Google-Smtp-Source: AGHT+IFMrxghikRrokajWNq7Qgw70xbXKxuDnySNPyGwfwT2Ss7893xwolfUMGoDpYSi2hTG/afasQ==
X-Received: by 2002:a05:6214:c88:b0:6e8:fa33:2969 with SMTP id 6a1803df08f44-6eb1b8391fdmr53856596d6.10.1742311525741;
        Tue, 18 Mar 2025 08:25:25 -0700 (PDT)
Received: from f (cst-prg-67-174.cust.vodafone.cz. [46.135.67.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade209bcdsm69412376d6.24.2025.03.18.08.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:25:24 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:25:15 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Andreas Gruenbacher <agruenba@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 3/8] lockref: use bool for false/true returns
Message-ID: <ptwb6urnzbov545jsndxa4d324ezvor5vutbcev64dwauibwaj@kammuj4pbi45>
References: <20250115094702.504610-1-hch@lst.de>
 <20250115094702.504610-4-hch@lst.de>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250115094702.504610-4-hch@lst.de>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Wed, Jan 15, 2025 at 10:46:39AM +0100, Christoph Hellwig wrote:
> Replace int used as bool with the actual bool type for return values that
> can only be true or false.
> 
[snip]

> -int lockref_get_not_zero(struct lockref *lockref)
> +bool lockref_get_not_zero(struct lockref *lockref)
>  {
> -	int retval;
> +	bool retval = false;
>  
>  	CMPXCHG_LOOP(
>  		new.count++;
>  		if (old.count <= 0)
> -			return 0;
> +			return false;
>  	,
> -		return 1;
> +		return true;
>  	);
>  
>  	spin_lock(&lockref->lock);
> -	retval = 0;
>  	if (lockref->count > 0) {
>  		lockref->count++;
> -		retval = 1;
> +		retval = true;
>  	}
>  	spin_unlock(&lockref->lock);
>  	return retval;

While this looks perfectly sane, it worsens codegen around the atomic
on x86-64 at least with gcc 13.3.0. It bisected to this commit and
confirmed top of next-20250318 with this reverted undoes it.

The expected state looks like this:
       f0 48 0f b1 13          lock cmpxchg %rdx,(%rbx)
       75 0e                   jne    ffffffff81b33626 <lockref_get_not_dead+0x46>

However, with the above patch I see:
       f0 48 0f b1 13          lock cmpxchg %rdx,(%rbx)
       40 0f 94 c5             sete   %bpl
       40 84 ed                test   %bpl,%bpl
       74 09                   je     ffffffff81b33636 <lockref_get_not_dead+0x46>

This is not the end of the world, but also really does not need to be
there.

Given that the patch is merely a cosmetic change, I would suggest I gets
dropped.

