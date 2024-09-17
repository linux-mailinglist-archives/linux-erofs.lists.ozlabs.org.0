Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3403B97AC51
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 09:44:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X7DMB5jB2z2yMt
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 17:44:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a03:a000:7:0:5054:ff:fe1c:15ff"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726559073;
	cv=none; b=BMl38voCk/sgns4qyhtQ3xrfs7AVCx1Tspqvo7fa9WCP29sAhwhIqBp5OlHlmUTXYI4ubyOXQSNYysw/Zk+6cnmWXwX1r8wCTnjtDFGyE6U4hej/J6fuVCwDRkSZjW4768skCoHywijkv8dkE6+EMS4cgUkMQBYZjLGRtlJ4PtE3ijQbE11UTYPA4y5YSWHjSERcCUrEC3l2r+YtzxyldeT7PVy1/3l6DMsDH8TXLXdTteTxuUtO5lG4Ql27IeD1v9nWWRjS9CvKfsQLoZS0XI+TjBVsaYt598KO7bQmGbMfDTZzLHoR9ENrWT5yqbbD0S5fJJrm7ifbzVJPpWVUDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726559073; c=relaxed/relaxed;
	bh=9cCDNqUqku74cuT7uPSo0Wm5Piy7EOaKF6xGAapJSn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4WafkYkNq8sQAaQYrPnmw8QDy1kzVjYOoUYbHp96to3DhAyTlm6RNMy19h/r3ySSMhcrKiP0TC9IZ99Uv77a1LOAfhuuDUSWv/614Kzv8QoaCAeg1W2tCRKWrOwL3v+3JXAlBm1SwOC5KcEETGtaivsrSrvstjSFqzAX7HA7tfqnZbFgO0gaxfe2i/yrsuZnitfHqoVnMuiYgspfCZbB438Lb+7vuFGI5+SzekyxQG5XIpsZ3cBb2Mt1cj1gB6bcd26s+BY+miYkgZ5HtSrZU6c/ztIYrNQgN3bTtsVnm5P6F7OAbLOuEgTePj/Ml7e3QllZutywbwxN63uh1WUDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=MlGiO8IF; dkim-atps=neutral; spf=none (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org) smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=MlGiO8IF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X7DM51yzZz2xb9
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2024 17:44:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9cCDNqUqku74cuT7uPSo0Wm5Piy7EOaKF6xGAapJSn8=; b=MlGiO8IFgA/5EE8FaV84k6wbe5
	hL87z/Km4WaN9jOXFpYpVWjE00u+bKu2Whq+a5UKdOEEg7YJ57e4DcFyeOGak3IabNckm1PpwrbgY
	K12LtGN71UYaDm2LotNk6R14LIpbc7MVqwemmNVAn7HLHBXA7v+ZuRMRgUEK9zxNCNRBFG61pOywl
	2kogj/jVtNYd2W9thyz44rcpHCWOB2F+odMecViYUCdYGkSztpnASLeKU8o7QVPULgXddI2Hmleof
	R5ltXXvY/SXeeHjNwXD7H26eQsTiRQc0lSIMWiH+jGxAN/DGSeKZm0eSDMaD6Vj3CLsq1f9JOh3Gu
	BMonxIIA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sqSsv-0000000D8Ft-3xHZ;
	Tue, 17 Sep 2024 07:44:29 +0000
Date: Tue, 17 Sep 2024 08:44:29 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [RFC PATCH 19/24] erofs: introduce namei alternative to C
Message-ID: <20240917074429.GE3107530@ZenIV>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-20-toolmanp@tlmp.cc>
 <20240916170801.GO2825852@ZenIV>
 <ocmc6tmkyl6fnlijx4r3ztrmjfv5eep6q6dvbtfja4v43ujtqx@y43boqba3p5f>
 <1edf9fe3-5e39-463b-8825-67b4d1ad01be@linux.alibaba.com>
 <20240917073149.GD3107530@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917073149.GD3107530@ZenIV>
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

On Tue, Sep 17, 2024 at 08:31:49AM +0100, Al Viro wrote:

> > After d_splice_alias() and d_add(), rename() could change d_name.  So
> > either we take d_lock or with rcu_read_lock() to take a snapshot of
> > d_name in the RCU walk path.  That is my overall understanding.
> 
> No, it's more complicated than that, sadly.  ->d_name and ->d_parent are
> the trickiest parts of dentry field stability.
> 
> > But for EROFS, since we don't have rename, so it doesn't matter.
> 
> See above.  IF we could guarantee that all filesystem images are valid
> and will remain so, life would be much simpler.

In any case, currently it is safe - d_splice_alias() is the last thing
done by erofs_lookup().  Just don't assume that names can't change in
there - and the fewer places in filesystem touch ->d_name, the better.

In practice, for ->lookup() you are safe until after d_splice_alias()
and for directory-modifying operations you are safe unless you start
playing insane games with unlocking and relocking the parent directories
(apparmorfs does; the locking is really obnoxious there).  That covers
the majority of ->d_name and ->d_parent accesses in filesystem code.

->d_hash() and ->d_compare() are separate story; I've posted a text on
that last year (or this winter - not sure, will check once I get some
sleep).

d_path() et.al. are taking care to do the right thing; those (and %pd
format) can be used safely.

Anyway, I'm half-asleep at the moment and I'd rather leave writing these
rules up until tomorrow.  Sorry...
