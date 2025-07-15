Return-Path: <linux-erofs+bounces-620-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2778B04DE4
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Jul 2025 04:40:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bh3Lt2BgTz3bwf;
	Tue, 15 Jul 2025 12:40:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752547206;
	cv=none; b=OTeEQI9K0F5pQlGhq62dLT3DlS8hkzzBknp9C0RrfAc/7uctuC5q344HRK4hW6nx5RsWl5GQ55aXuxlxq6kLNpfq+rKmDQKhRFmsttbLlyATYDhSjatTyYz6MEMLsO/WEqQ0wlUhCUYbITgYiTNFbdbv5ae9pfdNBzjKVP1iVPRr/EPZ7Sp0Ps65xoEPZIQQq5FhqVaYaWaT49ieTaiSHBb0SGN1GSlq0x/V5eelMdAvu5wFNqdDvuPTtSE8r4gXTvjHJEcKqGW2RB/F5Cvy6E/46Yiq0QktRAUae01L4Y1oWG7eVSu4Vd9BpCLzbU9QMHfY8QA1Cyd637aLNrmtfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752547206; c=relaxed/relaxed;
	bh=85p9i7y7K8gYrwGcixmFzJyazDjux/v6Ar0Mh9dEROY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JcUYFwo+qRpBKNu0DeddZOOTM8p3M8QnK2jOzQfFcyjcfZZjjQDoH2aNrzASSRVy3EQw1ZnhINpWo3nRWDPfsl+TNjADXUD8PQrJxaf1LqGHwqz1ustr/Ux9qasFitS3vGuHKwNoMwfYo9L6MVFDfEkwl6NVkgEmaYV6tviQA8/qxyS+Fz20r5qEskKt67mIjc6GWX8bf/60CAoHqxNEuLFkCL8BvOhXEzIaAIy4JPOhXyqUmnddymbvTF6/F2+76eqQSEiKyzY90zyNkIb/hQzvtfxXkHCIVZIVZI3A8t4+WhS/TNJUu0Hcusz3aZmaZZTJXK1Gj7/ju13O0QN7TA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Bc4odNem; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Bc4odNem;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bh3Lr4h7tz2xBb
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Jul 2025 12:40:04 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752547200; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=85p9i7y7K8gYrwGcixmFzJyazDjux/v6Ar0Mh9dEROY=;
	b=Bc4odNemFhyNBn6E2Tsq+siNArfukRm4hMhwWxnSToi9C9Vcu+l31ylX3HxzsXgQnEdRzS4YJ95aM96BW8/HCUmkTM4I7cIKT+I5oFT4iN6QgCK4QloEFd8T29pvKgaX77/DbgLNmClQmGM17pyWGrmI7rycPpgl3mSbuWhjz0I=
Received: from 30.221.131.147(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj-Suoi_1752547197 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Jul 2025 10:39:58 +0800
Message-ID: <a7152875-a9aa-40a1-b138-926dbab4f491@linux.alibaba.com>
Date: Tue, 15 Jul 2025 10:39:56 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: fix memory leak in xattr handling
To: Chao Yu <chao@kernel.org>, Sandeep Dhavale <dhavale@google.com>,
 linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, kernel-team@android.com
References: <20250711233548.195561-1-dhavale@google.com>
 <4c651095-7840-4015-acb0-1375ca428317@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <4c651095-7840-4015-acb0-1375ca428317@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Chao,

On 2025/7/15 10:35, Chao Yu wrote:
> On 7/12/25 07:35, Sandeep Dhavale wrote:
>> In android the LeakSanitizer reported memory leaks originating
>> from functions like erofs_get_selabel_xattr.
>>
>> The root cause is that the 'kvbuf' buffer, which is allocated to
>> store xattr data, was not being freed when its owning
>> 'xattr_item' struct was deallocated. The functions put_xattritem()
>> and erofs_cleanxattrs() were freeing the xattr_item struct but
>> neglected to free the kvbuf pointer within it.
>>
>> This patch fixes the leak by adding the necessary free() calls for
>> kvbuf in both functions.
>>
>> Signed-off-by: Sandeep Dhavale <dhavale@google.com>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

I released erofs-utils 1.8.10 hours ago to resolve some
fragment mkfs regression so it won't be in appended.

But thanks for your review!

Thanks,
Gao Xiang

> 
> Thanks,


