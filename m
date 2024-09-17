Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129F097AC94
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 10:08:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X7Dtx1JgHz2yN1
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 18:08:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726560514;
	cv=none; b=QT8elDTKW3X+nXL0ls+KjUHJhrIxjC5Fl7wIrzalEJ8wYOmjp0ytcGmMY6NL75UJRTFfNR1gXGzNFlOggS+uB61j9DKngFHmbWwZ30P6ch0ouTvUymMxlVJgelq1XXiisla4sa0iyCFngDejcKjmqqj1HugfRrRB+tySVHwBUzXjsUQuhgshqyJ+h8mBfV/TqQDDvpjVl0IbUoctfgWEHqsmAXDjQ6FdxPvmMxdlvXTBr2L9gDK5hgHrpgVN8ibR2CIme9+w1K//Z1pPX9/ixqcY0qPFBgP2hPA3Peu64lWHHZ6Wgiml5TATme/CoWf0iX0GvM4wPf31fYHpW/VagA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726560514; c=relaxed/relaxed;
	bh=I8eWoKaw2PNnTTn7YsG5l65WbNKRB5CSK40+WOhrwfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MlEMFPzmYa2YPKqVnV3V0oGQi/hZLoCszFlLXQsZWPc7j+T7GVrwuX0ala7mOxWAEDLMbced8zhCLDf++mKSPvHy7oj2yXpXTWn5BFV6eTqYNSRRju2gZOudqfb8lFOU90iwOc+oKSh2Rfp+S7QNIN5HJpPtQqzaDdLGqgNrB2eYI+o5n7C5xB1nCrlHPFKPrbyN0KCg2hgANU41+8GIKWCxXEJXMQ9dZ9+hkjPxby4eoW5vVynt1Cc9ipz1JgplZlxHnCHzg/qteV+WP092GBq9XVJkLdw9vatlNcHdnhUwIExgH73gUoMUNsfHEpqvIbELXuBQtskbyEUxQLbZHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tag8/vLu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tag8/vLu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X7Dtp0hDxz2xX3
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2024 18:08:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726560510; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=I8eWoKaw2PNnTTn7YsG5l65WbNKRB5CSK40+WOhrwfs=;
	b=tag8/vLuQRUGMn3/Sv2rFsUFpTaFQM+ScGijADkuUK7bZwRaExsS0zuBbwfv90o2EZqtrZ2W5xgrKnYip5bGhHRIvhWff294N+UP6hEea7RfALNIW20z0+WGwdW5yy1BirS3rMjmhfmkPCAjoI5ObAfOZg812SOheFh5+UqUljI=
Received: from 30.244.95.26(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFARatd_1726560507)
          by smtp.aliyun-inc.com;
          Tue, 17 Sep 2024 16:08:29 +0800
Message-ID: <8871d954-4e6d-4e2d-9080-c5950e7ac2c6@linux.alibaba.com>
Date: Tue, 17 Sep 2024 16:08:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 19/24] erofs: introduce namei alternative to C
To: Al Viro <viro@zeniv.linux.org.uk>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-20-toolmanp@tlmp.cc> <20240916170801.GO2825852@ZenIV>
 <ocmc6tmkyl6fnlijx4r3ztrmjfv5eep6q6dvbtfja4v43ujtqx@y43boqba3p5f>
 <1edf9fe3-5e39-463b-8825-67b4d1ad01be@linux.alibaba.com>
 <20240917073149.GD3107530@ZenIV> <20240917074429.GE3107530@ZenIV>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240917074429.GE3107530@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, rust-for-linux@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/9/17 15:44, Al Viro wrote:
> On Tue, Sep 17, 2024 at 08:31:49AM +0100, Al Viro wrote:
> 
>>> After d_splice_alias() and d_add(), rename() could change d_name.  So
>>> either we take d_lock or with rcu_read_lock() to take a snapshot of
>>> d_name in the RCU walk path.  That is my overall understanding.
>>
>> No, it's more complicated than that, sadly.  ->d_name and ->d_parent are
>> the trickiest parts of dentry field stability.
>>
>>> But for EROFS, since we don't have rename, so it doesn't matter.
>>
>> See above.  IF we could guarantee that all filesystem images are valid
>> and will remain so, life would be much simpler.
> 
> In any case, currently it is safe - d_splice_alias() is the last thing
> done by erofs_lookup().  Just don't assume that names can't change in
> there - and the fewer places in filesystem touch ->d_name, the better.
> 
> In practice, for ->lookup() you are safe until after d_splice_alias()
> and for directory-modifying operations you are safe unless you start
> playing insane games with unlocking and relocking the parent directories
> (apparmorfs does; the locking is really obnoxious there).  That covers
> the majority of ->d_name and ->d_parent accesses in filesystem code.
> 
> ->d_hash() and ->d_compare() are separate story; I've posted a text on
> that last year (or this winter - not sure, will check once I get some
> sleep).
> 
> d_path() et.al. are taking care to do the right thing; those (and %pd
> format) can be used safely.
> 
> Anyway, I'm half-asleep at the moment and I'd rather leave writing these
> rules up until tomorrow.  Sorry...

Agreed, thanks for writing so many words on this!

Thanks,
Gao Xiang


