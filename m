Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 926049E79F5
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Dec 2024 21:21:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y4jMk1MkDz30fM
	for <lists+linux-erofs@lfdr.de>; Sat,  7 Dec 2024 07:21:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733516496;
	cv=none; b=OqcBFf3NPJ7+QeGBmgTg9HF0Dq1zkehuSH0fIK3hAKLhOycwFq83cJdRCbJFRIOuPSH0hH47HwxwlBNqRU6plUkVLUpATbivYvt+XIl269oj5RbVXO3e5N+5TYq+HtuQiZnUrS+Oe36FjqIZarhtFPygiOVtR36fq5yB0cXY7ams/FjX9c23KePwomz9wB/VQCq/wVjqi4G34yU1raWeF+oQe8+9QIbWEog8leQsWSxv7a1xbEaOqujOcdTlX8TQRw0TVBlz7yZCSHz6aA3kWyFQeYKQOlcU/kvsdXQnVPDx/TUG8Li7VJMJscn33maZ8GC3IObfahN4Evw3pl+w2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733516496; c=relaxed/relaxed;
	bh=xAIdDVdkKVBJ/ohd/7q3R4q0nVA/LGa6ulblcTsg53s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n0vLFIwviMMNs2mreMGpVpeRszvIjmNaUgMQN8REEMjYKB9gD8X3lLGy6lo6mDSESc2B8CZXk1Ap5i2utEapx5ww3egKKxgbZdtHxjQd8U4nlsb29v39mcAm0+OaLQXd09Mxp45F8iNWKiON9q5BfSITrR2IsURNzut2csHUvs8hwS7IvGWee8CrOYcUOU9mVtym73SddZLk0EddjlyLszk4S8pYJJLIE4hY6mCt2G0rQUvw6hSwVnVCV7/EM7WeEzx0ofCUZ5J2R78Stgt51YkrRErenhX55dUtzwVx4+ig9LX7pXXmpE4rkGwRUuef9mTPn6VlL72JtBY6myM/Uw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QPUSkVBX; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QPUSkVBX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y4jMd0PYjz2yHT
	for <linux-erofs@lists.ozlabs.org>; Sat,  7 Dec 2024 07:21:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733516486; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xAIdDVdkKVBJ/ohd/7q3R4q0nVA/LGa6ulblcTsg53s=;
	b=QPUSkVBXb55/yjCTPUo/MQbSidmBo/+BTSngNBocLoAB7BSN0mwGUcbhM1dt5Lew8hNwOg/Ry1PDUub1scV9/5Ce1Pte1AWQARbf+QWbVl7CuzHLtbOBFg99v8Z3cUJalbnkNyq6oIUBAJ4TxEwCnRrJBGeq0a6mYWfX/kKQ+BQ=
Received: from 30.170.86.122(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WKxXTqh_1733516480 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 07 Dec 2024 04:21:24 +0800
Message-ID: <99520f27-6080-43ae-9c60-cc30d3a8ff5f@linux.alibaba.com>
Date: Sat, 7 Dec 2024 04:21:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mounting 4k blocksize on e.g. 64k hosts
To: Colin Walters <walters@verbum.org>, linux-erofs@lists.ozlabs.org
References: <406ae215-0f60-4f19-9be9-122739682056@app.fastmail.com>
 <17b4f35e-a365-4460-b2a4-9da660ae3e95@linux.alibaba.com>
 <55ea18fb-7309-4328-a2f9-bebb5db61e87@app.fastmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <55ea18fb-7309-4328-a2f9-bebb5db61e87@app.fastmail.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/12/7 04:10, Colin Walters wrote:
> On Fri, Dec 6, 2024, at 2:46 PM, Gao Xiang wrote:
> 
>> Did you try upstream kernels? It's already supported upstream
>> since Linux 6.4.
> 
> Sorry, my bad. (It should have occurred to me to check, but this one popped back up on my radar when I'm trying to do several other things at the same time).
> 
> Anyways looks like the fix specifically was https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d3c4bdcc756e60b95365c66ff58844ce75d1c8f8 ?

Yes, although it has been supported for nearly two
years, but there are still many dependencies
against RHEL 9 kernel (5.14) codebase.

> 
>> I think RHEL 9 is lacking of many features.
> 
> Yes, but I'll try to argue for refresh for 9.6. Thanks!
> (Just tried to cherry pick that one myself, some conflicts but looks tractable)

Actually, the PR below has been delayed for
months:
https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/4123

I think it's not quite easy to just cherry-pick
random commits due to twisted codebase cleanups,
rolling the codebase to upstream v6.4 is a good
choise for RHEL 9 long term maintainence.

On my side, I could even help submit these
backport, but I have no idea why the PR above is
still delayed.

Thanks,
Gao Xiang

