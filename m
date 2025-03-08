Return-Path: <linux-erofs+bounces-20-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E00E7A578C9
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Mar 2025 07:44:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z8tss5rW1z304x;
	Sat,  8 Mar 2025 17:44:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741416241;
	cv=none; b=EtzkUSbpMMgVQ08uhOVRczSbCr2o363lTsmDyEJp2YCVVPoIq26E115bcwo55uwQRgR4OkxIdE75SPeeFla3zm6QH84kR3N5hS9/RpumS3XdsuGtZ4UBGUd5439AmWKycQtgNPFKdmUjtxSIaX+Tp8j1G7edqECniBN4nz7jDfiLDzTbpLDlzBWgQgIxB437HNLPRqzt2HfgjqCn3lKx5XDJzofIhELzccjaMARhN1IYkfrXL0XP30MF2WFtvFL7IfDeJdyqTDRvGvmK+TKTkDuFDSei1YZoT5ukUkMJNBftcP2LLvoAx5SUmq8AwQ59LBszEsA84oTeks4oaOAnoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741416241; c=relaxed/relaxed;
	bh=L7XYd6bILvV5S9oc7kfROdvIGE+piMUFy2TT1wDFAAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgFFWpw2R0JyU25ORkijDbm1OMk6jJ/ko3Uy62yE1siPd3NJ0EBVYgsaUt2fCcv0Psq7jED1O+T4OtHNG8r2PMgpNa4kQGG07a9ZyVmw8CWL3/0YbevnJSJYGIAfzbHF5D2FRJym/2B/3KhHKOeE0mjvsvf5zXL/+0GP7gCA+lkcq+8flfqkd3rb9iBOwIjFKOcGksyq4o7PiSlRtoZA80fF9Fdgmg/tAd50hnAGoHI6q6lt3FtY8RSYlT0+mVTE5jHIMAr13s4weJXSeMcxZ5DkjpWKi7VWewVTVYsqivbYZZXGVo4Nc/H0e1WbVJQ5Otwi3eySpPWHv97+NPOxDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; dkim=pass (2048-bit key; unprotected) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=sVOmSOiX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=david@fromorbit.com; receiver=lists.ozlabs.org) smtp.mailfrom=fromorbit.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=sVOmSOiX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=fromorbit.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=david@fromorbit.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z8tsr5c6kz2yk3
	for <linux-erofs@lists.ozlabs.org>; Sat,  8 Mar 2025 17:43:59 +1100 (AEDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-22359001f1aso65318855ad.3
        for <linux-erofs@lists.ozlabs.org>; Fri, 07 Mar 2025 22:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741416238; x=1742021038; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7XYd6bILvV5S9oc7kfROdvIGE+piMUFy2TT1wDFAAs=;
        b=sVOmSOiXIbdLEc0z8WdYgLCkDi+jlXbipBXH8TkBdTwyLwRdZTeYXVwEpbIkHYS+SE
         TMt+DN3dtbao7gubXdRUVJp76DzXd2qSaba6T4jdU1Tl6fikUdgDGJym6SXPpW0Eitpp
         0kuh/yT5D25wukN42BTXYRn3fv0vjDhvOP/VI0qONg+610Q8QY8Q+fOJWFBlt1+3tst8
         s1DN0LFO+cBCOmF4lEV+xBirvO/+eo6YJ3XuU6uaM1hq+Li8efaZq/3qDYE4zaGsDmgv
         nWF7DlPmyg/4tVQVEVKqZARWf86ymOqB2XiTefonREyQ6e0ZZtPUMSXbk0A0XGvEfh2W
         Gtew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741416238; x=1742021038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7XYd6bILvV5S9oc7kfROdvIGE+piMUFy2TT1wDFAAs=;
        b=uTPu2EpRq2HG4NJbQjuxTC6/GUA340L4DXzzHQ/DzoVXdHbWOpK+hCLp3JXI+iJo3p
         l/FXqmfCLNiJAAt3of9Ti6VG867k6X/g0V+m9nqa9D+lUHvQutvQS+uDj5CEKG2iJokD
         FDcguF1DANeKft/aT5PGB5UTQplav0whUcHGtFYXvGB/mLGv+v8T86Vf2QSgmhYRJ887
         AF672Fzn6eGVzGkH4PjVc7DEeXkM3gh7K6i50vPo3e5OAJzzZWdvbkk3wEnj8CXxG24v
         E1nN7w3CC2QoyU5TeoIA7Das+6KeUU+1ZCzcVwxRFYB/uz3WWLuOIcbfYytwoihyA8pL
         j1pA==
X-Forwarded-Encrypted: i=1; AJvYcCWI7PqbapHZtOZNWjKZSx5NkVe4WlNwMwQkZEGKeabKb2kE4kui+PbvlHieFb1z4Xgh7f/Tz/61jiXpQA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyqpwoznKIQ9at6L4yp4bYyE2JXqJj6JfGZg7px+JujESLUw5IJ
	UAXxkwxawcFVwNzkP2/oWuWyjb8B1cc5teUr9X+9B3W/bmE0dLM5GtwEMBUs98I=
X-Gm-Gg: ASbGncvyFLG8+v6cOKI7G2GA21NJH4L5fZ1+EWotF289OkS8ve4HcMP0R9nabwILohu
	pAr1oWGySriq+n61lCRO/SAlcl+aNM7sndWXIIVhe0yVtiJqqqTlXrpmJZiBgZ+NA5NmUMmyM4S
	DheydP8hzPZP9nBu6PycM79Dy97r1chu0uK+ekUbER4fKZI7jUWP/PNrQrJPIE1FPvTWc2im08Q
	6KszOswzwfRW7AT3DBH0IyZCIH0R7qHqVJXpxGWbtp/d5cKVQp3ci5YtiWKwdy2LfNot1iqMtv2
	VL82B3S8+nuJ7P+XiqHe3hiUCjV3jubxa3Ld+/JQdgQyTLcwDt2uC466teXlz0KJMBbDG521Fqa
	+0UZTjRtPppx/7JVnEa53
X-Google-Smtp-Source: AGHT+IF/hoytkHf/78nzK/gEIzqXnGG5MP6Y8FgGhVp8Zx6LE+l7N0K13IdyKh5Omm9Q6AhxhqYyLg==
X-Received: by 2002:a17:903:98b:b0:223:397f:46be with SMTP id d9443c01a7336-22428ad4a09mr106979815ad.47.1741416237682;
        Fri, 07 Mar 2025 22:43:57 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e816csm40661065ad.54.2025.03.07.22.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 22:43:57 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tqnuc-0000000ALct-08Dn;
	Sat, 08 Mar 2025 17:43:54 +1100
Date: Sat, 8 Mar 2025 17:43:53 +1100
From: Dave Chinner <david@fromorbit.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Luiz Capitulino <luizcap@redhat.com>,
	Mel Gorman <mgorman@techsingularity.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] mm: alloc_pages_bulk: remove assumption of populating
 only NULL elements
Message-ID: <Z8vnKRJlP78DHEk6@dread.disaster.area>
References: <20250228094424.757465-1-linyunsheng@huawei.com>
 <Z8a3WSOrlY4n5_37@dread.disaster.area>
 <91fcdfca-3e7b-417c-ab26-7d5e37853431@huawei.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91fcdfca-3e7b-417c-ab26-7d5e37853431@huawei.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

On Tue, Mar 04, 2025 at 08:09:35PM +0800, Yunsheng Lin wrote:
> On 2025/3/4 16:18, Dave Chinner wrote:
> 
> ...
> 
> > 
> >>
> >> 1. https://lore.kernel.org/all/bd8c2f5c-464d-44ab-b607-390a87ea4cd5@huawei.com/
> >> 2. https://lore.kernel.org/all/20250212092552.1779679-1-linyunsheng@huawei.com/
> >> CC: Jesper Dangaard Brouer <hawk@kernel.org>
> >> CC: Luiz Capitulino <luizcap@redhat.com>
> >> CC: Mel Gorman <mgorman@techsingularity.net>
> >> CC: Dave Chinner <david@fromorbit.com>
> >> CC: Chuck Lever <chuck.lever@oracle.com>
> >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >> Acked-by: Jeff Layton <jlayton@kernel.org>
> >> ---
> >> V2:
> >> 1. Drop RFC tag and rebased on latest linux-next.
> >> 2. Fix a compile error for xfs.
> > 
> > And you still haven't tested the code changes to XFS, because
> > this patch is also broken.
> 
> I tested XFS using the below cmd and testcase, testing seems
> to be working fine, or am I missing something obvious here
> as I am not realy familiar with fs subsystem yet:

That's hardly what I'd call a test. It barely touches the filesystem
at all, and it is not exercising memory allocation failure paths at
all.

Go look up fstests and use that to test the filesystem changes you
are making. You can use that to test btrfs and NFS, too.

-Dave.

-- 
Dave Chinner
david@fromorbit.com

