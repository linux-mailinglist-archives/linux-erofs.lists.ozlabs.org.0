Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A765999B29
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Oct 2024 05:23:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1728617036;
	bh=F/DrQfgMdhifUqq4zT+vZ6JGj6MwJBh4W170nOaFSiY=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ij1jbNT20tbOsHzDfGVbmrpsHnDz1/VzlwTUrwZktjB+vJsZHRnSlMwhenB/hxZt2
	 FSQWp+2+sQRQgWTceJsVyREKZUxqtUZ7HR3yDAIvTwlKexxLGFDhKDQDcnbYD3r3Jp
	 2iz1ieLRdrhMzl30bWjiDYe2MBQpwq/E+1E8GIV34g4pJJrUYEQzqWZL1ovBNy8Seo
	 MFVtyCDOndWtdi9N36/s4uhHeETj1r2u4Tj9Nl8P323a0BL5lDTcrjrN9Jd5R1cG/5
	 LNubH4F7+DiDxEBv7v7DRW8z2Pd5TYOwoYc37xm92mt2z0azyVB+kKgJpmg4yclEDX
	 fSoEb8BHWgjeg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPsRJ3yvlz3bm3
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Oct 2024 14:23:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728617034;
	cv=none; b=C3IewAA828bATGBHVhWWFR5PktgIZszrXQqT5hzeBFmUCvBhLvj1zUe7ELQo1/kbVVR6p1FeYIQIXCCAgNvisUvjr4RtN5oXrUWeCZ8Nd0Ow9rddcLpfqhXVzLStG+BJ0pjdMqqtezbbf1TjvT3ywHqDyMQ9xKpw34g7KYeORiJTrvIm+K8Vc0Y9VfBXw4vKA7+0eHbyHh+v7zdE3GbiQGgfM2LUCgldZvP6qnY3kLqmqRSWbQE8tWG7SbbqnuPsF51Z5Q63lgo3ZxwvP1Y5jFL9lZXM6QbDsW7HSvfmv8C99IE/ugs0YetwrUqY1dosvHZxwHzV3uR7JDzrdSdUGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728617034; c=relaxed/relaxed;
	bh=F/DrQfgMdhifUqq4zT+vZ6JGj6MwJBh4W170nOaFSiY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gm9MLkR1KxrW1r8cT9yC3cixUTIezTh6Sd4MTWysbG69NX/UweR3lhiJ6uroRqNofHVqYafvE7MWVtlwBHefJP5DQCCKmOim77dLOIM1j/Vq/QcrJm39ox/nI7Zj26yDc5R+hQ7K12HoyZqJAJIJP6dyl5FTN7fLYLewvqW1xFajKJfGjloEm3FIdwkDF1RqG55s3R7D33UzFMMcYc12ZDCCPZy8nzngbKtyWAwNiD7Xv+wjYFwI53RIM7hqAGNYQiBtsyxo8QqKm9MpitiNMLk0e4rDUvxt6PzjZHg3h5WzqegzvEJgeiT0eTuzRbXtQwBd+HGFxicsvegw12ziZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZwBup2Ft; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZwBup2Ft;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPsRD6pLlz2xjv
	for <linux-erofs@lists.ozlabs.org>; Fri, 11 Oct 2024 14:23:52 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 006D95C5A18;
	Fri, 11 Oct 2024 03:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB96C4CEC3;
	Fri, 11 Oct 2024 03:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728617030;
	bh=Uebx/oNcKWECtLhnrymtjaw7rE4TW8QKrIUn/TUZzJI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ZwBup2FtT3HzT32tEiDuzeonnigpQskMYb0iYtniVwZGnX0LdRVFdO/Q3Qd+9d/2F
	 +C4jAeDAkGxqLcFtlYAIjWQwpPoHQphny3GGQ3ZI7v0R3yGBCrhKvm1BOM+4ZH00tV
	 sOR5ioU+8V2vbu6zbJ2ZG8oMMxZCYpm6nCtipXgwdgrYfqB94IsYH0Fk5FWT8js3Ep
	 wO8lrVV6dyPAwaWjjkh5qvcMGKxtrFAHlUIvW4MkHuw67k5J+V7AWg2KdHxSveudJp
	 aceCuOZ4ROMyk/pkbExi+BYR0mqi9C4/IxtOZHbwFIyVeRJVoPNrRtP5SraWOJqzzf
	 EtrRjBMh/Ekzw==
Message-ID: <a6ed3ae5-8ed2-4e7c-a790-8771adae121c@kernel.org>
Date: Fri, 11 Oct 2024 11:23:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] erofs: get rid of kaddr in `struct
 z_erofs_maprecorder`
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20241010090420.405871-2-hsiangkao@linux.alibaba.com>
 <20241010235830.1535616-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20241010235830.1535616-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
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
From: Chao Yu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chao Yu <chao@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/10/11 7:58, Gao Xiang wrote:
> `kaddr` becomes useless after switching to metabuf.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
