Return-Path: <linux-erofs+bounces-23-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484F8A58487
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Mar 2025 14:41:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z9h4m5P7fz2yjV;
	Mon, 10 Mar 2025 00:41:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::643"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741527672;
	cv=none; b=gG9fzSBsMJqO2vhw+bgW9EvuW0MIifGeaz9Ce3heW+Mc9QBh5wOkhuvbVdTnjw5Ol3FPjyQVRUsDG6F+XXbh6lD7cAuOwVaTfJLgVt6CONgo98ESx/vJ384WO4lxUcJLyWgOLo7to0/fbbRPhYUW4GvY41dtwItrzPa0VBUBbPpp9sI5sTDw9TFnIBqrqpFXP4B1zrChKakdmksgSfa37ZyKPInXv11XS1aS7EdmbRDUCs11aEKqvQ33T7do3XAkLEAh6F6eVMRUHHo3xrY02JPcZQOfixbO/EMQRowYk5AKU0iVP/KBWLsovLMCNgQKWN6xou1xFAVGUtghskcifg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741527672; c=relaxed/relaxed;
	bh=LbqFVYGZKiXAHZ9rqZe+rnsj7EpBf3DH/8Ue+vs/s7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjlyd+JvVX0CTLt/ux8WGZJRPJ+WQSeDPLChgTlA/Y8bkcQSsoyqG6cN/0MS/tspVCpP6nMhPvYtLBc2oiQI45dGHZpMeDppYMc82kRRVKUPEkeWpnT0YmD5LarAkvTtM2qZ0/VWem86l1/S6rFUOZ504uJMXr7fuU/S5Eb82wjQxiJBGRnaoXVFEiaNLiPBYi2Tg8eSVXiY0P6ukLEwUMIzn76jEp6+SwTrO5wvflBUCbrFKNvXMhq2iEKJESOV5pjejZSn9VTtDOLybOJkWMfTEHnxiQCVQVfJ4romWV/TorMnTtuUZrYjzXremofZE5cnq6qLyIrEDjQKLNYj6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Q5g8/ca8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com; envelope-from=yunshenglin0825@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Q5g8/ca8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com; envelope-from=yunshenglin0825@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z9h4l0DB6z2ygY
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Mar 2025 00:41:09 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-224191d92e4so54194025ad.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 09 Mar 2025 06:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741527668; x=1742132468; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LbqFVYGZKiXAHZ9rqZe+rnsj7EpBf3DH/8Ue+vs/s7U=;
        b=Q5g8/ca8jo1rtDTDmx9mI2I2Ni0MGBtZPxsArjBqtt4vZkCioYGz6XjDwuC69zI2WR
         ImOZ9wmk1PnsJ2FlB2/WM+k1CROEkHtuUMHd4UvpQJAqYuyZjx2Sr8gg29cCmNeGqbhY
         p0HXtwDnl0mnJGhcCG1rvJYnDo6pWP1Orwzpi05ZqcHPgY6wGp1eD8hi+SbulW/4Ugtb
         +CqQzEn2/bxcb0BTYzZ3jDnna43ojhseTVLHeeQMjvJgjC8gimqWeMP2ZTXzh4PsaR1B
         9zYcph8VamCH8EzMF29kFzGosuxCPxyLIhETWX+g1Uhacz5iC4wTj9S+Qe2Amcmc4GJT
         0mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741527668; x=1742132468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LbqFVYGZKiXAHZ9rqZe+rnsj7EpBf3DH/8Ue+vs/s7U=;
        b=tuZGcsdIi/iuO85VBbv8Hngk9uIbaYue5ItCGkum68s+vlZS4PMdxDgIuPcWjdncVG
         9AJs8v0s0SVc1X6+dZes3NSBIEUizBQPCKWTjNpz/UlGPOMa1b97/RL0UF4Bc3KeYlsJ
         m3NCVbH068Maltfh3lSHOLWDW8d4MZ4JeOBEW2s2hmodTL4qjS01LPCGNXIbEHF51qH4
         rcEJQh52/5kF6d2qnOf1cwMvS63/dL5km1iBPs/zt74CgoX8Y/OyGoWAQAMjXhygLqb2
         C+2RL4eD40hHNioEI86/B3yBIIp3pB/Hv9LoVMj689tQqtvglOm3xFquJh9Wqni/lggy
         Br1A==
X-Forwarded-Encrypted: i=1; AJvYcCU8ex8okCWPBuz0GHHZzpQGg+YHibRaaPSXwK/gpJ0p1n2sAR0FIa/g5ugs27IkVVrgkQv7xoBo7+eAHQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx6kddorvJPwh/4dDoDQ3Gc+Pxouasjm3/JJ5qHUNASOccqPMBW
	nvUcXTzFbWgJJunK0D3tXPckp2/GOy6DKTJUxTCm7oO2hTmMTu/o
X-Gm-Gg: ASbGncvgu99MYK1HERzR6BN6nuFHXlpOye9c+McbXsHLreTAr2ixjvcwsSrqFliWirG
	0IgEXQd0gevbQwSragUCDk/BXl+OkVi7U1R7LvkSoG4URZfzJlM2TCZnsnldyQfzswIiT+8GPmR
	2O5Vz2p0pvkDdLsu8wAuXgIBgEg6HSUJcRKnUzBaN44fBOtgrNztJy2WeH8J5CGznj7U0H3GAWZ
	+GVmYCGb61s5C6+DgKuxt586C+tfZ9AJeIJKoOC16s8OHqVbvPj26hwztuHp1IvRKkzAgo8VWTN
	kJnm5JXZDlsKbDxID7vj/0N41Krb1ZWXc/d0CdbeiI0W6auzqXa2zntGg+c49ll8b3nA/tTVRiy
	83w2sq2IglV/qFDvRkUe9ePi8JKxkHg==
X-Google-Smtp-Source: AGHT+IFypNCMIn41ibdTDNx4lnj5ojm64dR+2U0xpw0STk3CxsR4PZycEa3AfGJqpDAqBoyMWdx6gQ==
X-Received: by 2002:a05:6a00:2e17:b0:736:5c8e:bab8 with SMTP id d2e1a72fcca58-736aa9c1effmr17581861b3a.3.1741527667817;
        Sun, 09 Mar 2025 06:41:07 -0700 (PDT)
Received: from ?IPV6:2409:8a55:301b:e120:c508:514a:4065:877? ([2409:8a55:301b:e120:c508:514a:4065:877])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736d4d14f66sm619646b3a.82.2025.03.09.06.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Mar 2025 06:41:07 -0700 (PDT)
Message-ID: <cce03970-d66f-4344-b496-50ecf59483a6@gmail.com>
Date: Sun, 9 Mar 2025 21:40:52 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: alloc_pages_bulk: remove assumption of populating
 only NULL elements
To: Dave Chinner <david@fromorbit.com>, Yunsheng Lin <linyunsheng@huawei.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Carlos Maiolino <cem@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Luiz Capitulino <luizcap@redhat.com>,
 Mel Gorman <mgorman@techsingularity.net>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-nfs@vger.kernel.org
References: <20250228094424.757465-1-linyunsheng@huawei.com>
 <Z8a3WSOrlY4n5_37@dread.disaster.area>
 <91fcdfca-3e7b-417c-ab26-7d5e37853431@huawei.com>
 <Z8vnKRJlP78DHEk6@dread.disaster.area>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <Z8vnKRJlP78DHEk6@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

On 3/8/2025 2:43 PM, Dave Chinner wrote:

...

>> I tested XFS using the below cmd and testcase, testing seems
>> to be working fine, or am I missing something obvious here
>> as I am not realy familiar with fs subsystem yet:
> 
> That's hardly what I'd call a test. It barely touches the filesystem
> at all, and it is not exercising memory allocation failure paths at
> all.
> 
> Go look up fstests and use that to test the filesystem changes you
> are making. You can use that to test btrfs and NFS, too.

Thanks for the suggestion.
I used the below xfstests to do the testing in a VM, the smoke testing
seems fine for now, will do a full testing too:
https://github.com/tytso/xfstests-bld

Also, it seems the fstests doesn't support erofs yet?

> 
> -Dave.
> 


