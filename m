Return-Path: <linux-erofs+bounces-343-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A79ABB30C
	for <lists+linux-erofs@lfdr.de>; Mon, 19 May 2025 04:00:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b119Y4SFJz2xC3;
	Mon, 19 May 2025 12:00:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=47.90.199.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747620033;
	cv=none; b=D/FJ1+w9v+rbv8g0ugM3sDubyEguwvtw8A3zLczY8HqSmdkJwJkW4ZMDrg5jspxPIxr7/ODoyQqSFBC0hrcfMvapZESLS9/iYaWhSx2ZevI97LOe7XTyAp1dgni89DnKg1dN9glz0yLYitYcKT1tPY3KLyAOTK+v4JCdYg3tkRXumEkFfCalCt5ruyxPOlRRY+9ye0uOCc0Ghp7h7NGtt2np93FtrNqXmDSYmbmNkkO6wz1tYi7uIK4UI5ovqGvese0v6WpELkIIFecE363rV2C3PRzjuUvU98cM9l548sIrUnooYYbHlDnVnWCOJzG+V0K3VxfhsE8dmSpvIPOh4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747620033; c=relaxed/relaxed;
	bh=pJkyOTZGJEW6toYCemFMD2pr1SIOHrqibFGbfzweaQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7d6yFaQtBgRczxJj9i//Li+c6I7REuyYKyOYSIO0SWIdyy7m0nh1NmqwhWE09D46ivoU52q16ZKS4YwIcKsdL96RAEAeXnqQHrhaX8HZU6uZp5E9oHYlieeicnqCP5oovR1KUFfbM6lyEP9ZPPt29rJDGklkOuaa0tCGjED7VEWgsdmFlP99BS5Hwj5hCMf3QkFAb88FBfVgrciUVlpGG5Rtq8Z01UCIa8to0G0JPFIvQw7me0aIj87KF64xbLNf6FijymPdplhlb2N5W/ebEnSmCJmUGO5k/hBD3UgWy33CtPQ2VYNs0DyYWCS3lXzTXfD9shI/gKbA2zwq35cxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KzW/A3z8; dkim-atps=neutral; spf=pass (client-ip=47.90.199.10; helo=out199-10.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KzW/A3z8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.10; helo=out199-10.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out199-10.us.a.mail.aliyun.com (out199-10.us.a.mail.aliyun.com [47.90.199.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b119V6P27z2xBV
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 May 2025 12:00:29 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747620012; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pJkyOTZGJEW6toYCemFMD2pr1SIOHrqibFGbfzweaQ0=;
	b=KzW/A3z8jTRkOckWlCyF61qocgpvYsZjEDy7nM/CHdpBCeNYdRo0sIATryT9LPKpOgpah1t2eAKUr5SX33sPaCYTbZMgm2c7M4eLfb8YoHhUTBrbD0PN8/yg8C0gwzv2EK1dGUy7VRv2PUFFTMRjwR2tgenS0lnkA4OzORVT4uQ=
Received: from 30.221.130.250(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wb3oP-G_1747620009 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 May 2025 10:00:10 +0800
Message-ID: <e24e146e-ad6c-4ffe-88cc-3ab5368331bd@linux.alibaba.com>
Date: Mon, 19 May 2025 10:00:09 +0800
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
Subject: Re: [xiang-erofs:dev-test 5/5] fs/erofs/super.c:659:22: error: no
 member named 'off' in 'struct erofs_device_info'
To: Sheng Yong <shengyong2021@gmail.com>, kernel test robot <lkp@intel.com>,
 Sheng Yong <shengyong1@xiaomi.com>
Cc: oe-kbuild-all@lists.linux.dev, Xiang Gao <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org, Wang Shuai <wangshuai12@xiaomi.com>
References: <202505190150.4HUHevyn-lkp@intel.com>
 <2faff963-c96c-4576-8680-a3e9b432aba5@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2faff963-c96c-4576-8680-a3e9b432aba5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Yong,

On 2025/5/19 09:58, Sheng Yong wrote:
> On 5/19/25 02:06, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
>> head:   7cd18799175c533c3f9b1c2b2cb6551e2a86c921
>> commit: 7cd18799175c533c3f9b1c2b2cb6551e2a86c921 [5/5] erofs: add 'fsoffset' mount option to specify filesystem offset
>> config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20250519/202505190150.4HUHevyn-lkp@intel.com/config)
>> compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250519/202505190150.4HUHevyn-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202505190150.4HUHevyn-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>>> fs/erofs/super.c:659:22: error: no member named 'off' in 'struct erofs_device_info'
>>       659 |                                        sbi->dif0.off, 1 << sbi->blkszbits);
> 
> Hi, Xiang,
> 
> dif0.off has already been changed to dif0.fsoff, shall I resend the patch to fix that?

Nope, I improved some description. Will reply in the thread later..

Thanks,
Gao Xiang
> 
> thanks,
> shengyong

