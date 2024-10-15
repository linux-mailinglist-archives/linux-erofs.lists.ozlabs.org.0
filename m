Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CEE99DD08
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 05:53:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XSKvQ5G27z3cGg
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 14:53:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728964401;
	cv=none; b=enYlT21ptBl0h/5xVZoCdQM7N6l8FfyEp3mXQxER7BvvQ+IqIrYfaFxi/G3QLDjJh12DPGIQQQWGrfoWFFNBgxnFjEcnVrLZ1wnQF5oSkncH1MRF/WfnwVSX2AFdHXVYvV3kzntk89QVrOqnQBcgQKQNyWEjeJ4t+jZ+cnottuB8v2YhBA/jNPWq0OArFkrJwkgPxhnBmyQ22q/H9436NazMDxFNfK+qp/U1Ki/V9Y3GZHgqCIyEaz8EMTWFn9Z2+t2iUiF09lp2FtwQ8EZP8Fqua0iEYgl4agW6MVfng7DAqzBkxz3PBw61NpyAZoy075AYzRePmeHgu++heFnUUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728964401; c=relaxed/relaxed;
	bh=GyoFiN/rXaMe/m+aaklpP07LqfN1T2+8ThFonOV2jgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQmdicgRVl7d3e9Hej/dPyt58OFTvX0TIpbQTo8qQPek5nvRns9IvvySrrHquIRmSklgMe0RsoFiHkAXEoUJ4iQJ/ad93zgpMktlz2fK3INK0Y3R8RlVtdrtr5GChbDNdXB5pZS9b80+qVpZ6aZm0WFtsm5QB+yMdVpwVTjlMMxogBnEBegoNubTsQKWtXK3cdxbT3olwvj30okzlHWVT3lgBmUK9Qdw4jwiB5E8GgKL0d2glN2rtZoSFF/y8ASmUpUI88Pez+DSbSEd32tujeGAnunCT62RmcaZZHJ9VT+QZ5eZTwEGMf2HB7ReY97bQq/8W28loYYWHc9SmdeMQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tTiMym2h; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tTiMym2h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XSKvM08yGz2yNR
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2024 14:53:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728964393; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=GyoFiN/rXaMe/m+aaklpP07LqfN1T2+8ThFonOV2jgk=;
	b=tTiMym2hn0MQy3Ob3PPAInrEeTIWU4H3OFtbWtr2rJJOVvPArMXO8F0oprqJap0G1r3eW6wGpY0q5w4UAeO5PKTgBOngwBE4BDngjR0SfImf/zj2Ja/n2D9z982KjiF/0ILBGbYQSbXe/y9H1vlr7hfVjTCfmgT5uw5Hul6mVS0=
Received: from 30.221.131.163(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WHBoCoP_1728964391 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 11:53:12 +0800
Message-ID: <2d76e36c-95d5-4eb2-9825-fa5e739ae139@linux.alibaba.com>
Date: Tue, 15 Oct 2024 11:53:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix unsupported blksize in fileio mode
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20241015033601.3206952-1-hongzhen@linux.alibaba.com>
 <231e17e3-82c1-49f4-9cc1-b376b89205b3@linux.alibaba.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <231e17e3-82c1-49f4-9cc1-b376b89205b3@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 2024/10/15 11:47, Gao Xiang wrote:
> Hi Hongzhen,
>
> On 2024/10/15 11:36, Hongzhen Luo wrote:
>> In fileio mode, when blcksize is not equal to PAGE_SIZE,
>> erofs will attempt to set the block size of sb->s_bdev,
>> which will trigger a panic. This patch fixes this.
>>
>> Fixes: fb176750266a ("erofs: add file-backed mount support")
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>
> File-backed mounts should support < PAGE_SIZE sizes.
> You should just fix these cases instead.
>
> Thanks,
> Gao Xiang


Okay, I will fix it later.

---

Thanks,

Hongzhen

