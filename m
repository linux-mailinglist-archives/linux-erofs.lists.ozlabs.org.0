Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 034A2966EFD
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Aug 2024 05:00:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WwfsB06Scz30Tt
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Aug 2024 13:00:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725073227;
	cv=none; b=mDEMZ/7EPQXptg9+Hv9YMcrzu+ZjUY9EBPWCUig3iqgB7Dw/yiiV5H0EUrVQqJv+B5tyoI7ep3plrnybXUdG/GzuFSiGKpQL09fx0ddD667AHMf8KoPHkPDPY0IHx0edoOw8JLtXMXEp9AOETg9v0hZjFP1ESsR3/+8ipv5bjbIYJb2AoNns7o9yjTSqpeAoGNoAaxIebSAcTtr4ntCcrqlWMpjJmCRCHM9zdimsYcGk8a7sndMBLhvCTOXvXb6WfamWKCA0FTacG8xb0j8tAbcd5/DbjGcAnhpawJfI3YYVnXKAlti/PPO4SW0mnYcVs01T9XZ5G5P09dajqX5m1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725073227; c=relaxed/relaxed;
	bh=ncafHe3fLWN/Qi/tx6hfltABIG6ca2QF0UrKkJNtUwM=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=RsTaxvBb/ZihMEODAfZD3RK24MmA6naKWblwe/hi7QbbIaVfrqhE/U9NKjdCOIyJ0pqYj6Ya70EHQtaizv/gzW0UbpmbaFwZVrzPvbM3V4diSOrM/+XOiv9abMTjo/6F7KhU2902RQT3+824Xlocm9k0FlP9JcE3QUDAz4vB8zDOdBCGZZMpDaBlaS/cEz6RvuNz9JJePTlR8nYutd1UKyubzTMMmrBf9O2S8QPM2NrMLUDLmyeNR8ijNPU0Q4O9xrEM4dN9FoonDCtO25nzCuydZ7bH15dZcRtM0w+xGR0m4hyMDkMQKZ403mRMqGi/64pi1I0tFf2wBKYTWTt/GA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gos5pwyL; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gos5pwyL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wwfs64NCTz2yvw
	for <linux-erofs@lists.ozlabs.org>; Sat, 31 Aug 2024 13:00:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725073220; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ncafHe3fLWN/Qi/tx6hfltABIG6ca2QF0UrKkJNtUwM=;
	b=gos5pwyLV+HCCPdrlZXVouH6YHdj/0pcoosWFysl8zA2nTIWe3rQ7yJ4Yjv3txzDcpCt6+vGEu+I6fjqqBhxBPgq7yXCOSpUIlDjUOdcUM/h/LN0nz9koJxkJ5q9jVi54m7CwtnGD4lpBUoF75/5zxSyNXGM+4tLmxgSrZCEWkM=
Received: from 192.168.2.29(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDyLVXO_1725073218)
          by smtp.aliyun-inc.com;
          Sat, 31 Aug 2024 11:00:19 +0800
Message-ID: <134cbf1b-06fd-41fb-830b-ba97e6ae4bfe@linux.alibaba.com>
Date: Sat, 31 Aug 2024 11:00:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] erofs: add file-backed mount support
To: Sandeep Dhavale <dhavale@google.com>
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <CAB=BE-R3wU7hBBaeAXdkDp2kvODxSFWNQtcmc5tCppN5qwdQgw@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAB=BE-R3wU7hBBaeAXdkDp2kvODxSFWNQtcmc5tCppN5qwdQgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: linux-erofs@lists.ozlabs.org, kernel-team@android.com, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Sandeep,

On 2024/8/31 08:30, Sandeep Dhavale via Linux-erofs wrote:
> On Thu, Aug 29, 2024 at 8:29 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> It actually has been around for years: For containers and other sandbox
>> use cases, there will be thousands (and even more) of authenticated
>> (sub)images running on the same host, unlike OS images.
>>
>> Of course, all scenarios can use the same EROFS on-disk format, but
>> bdev-backed mounts just work well for OS images since golden data is
>> dumped into real block devices.  However, it's somewhat hard for
>> container runtimes to manage and isolate so many unnecessary virtual
>> block devices safely and efficiently [1]: they just look like a burden
>> to orchestrators and file-backed mounts are preferred indeed.  There
>> were already enough attempts such as Incremental FS, the original
>> ComposeFS and PuzzleFS acting in the same way for immutable fses.  As
>> for current EROFS users, ComposeFS, containerd and Android APEXs will
>> be directly benefited from it.
>>
> Hi Gao,
> Thank you for the series! This is an interesting idea and will
> definitely help the Android ecosystem for APEXes if we can remove the
> loopback device. I will take a deeper look and provide comments soon.

Yes, I've seen no issue so far, and it will be submited for 6.12
since there are many users which really need this and wait for it.

Thanks,
Gao Xiang
