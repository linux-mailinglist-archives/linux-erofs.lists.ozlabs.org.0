Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E0089CEE5
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Apr 2024 01:20:57 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=M7fOAl5u;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VD4pH4T7nz3d2n
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Apr 2024 09:20:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=M7fOAl5u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VD4pB3jmkz30Pn
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Apr 2024 09:20:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712618443; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gKF6T1PMxNOtjkiYvov25COpWDikgrZJeztTw2nxS8c=;
	b=M7fOAl5uGOfA7jvK2RGflFL0MJ0ubfWztNBEfIRxCJw+nAXG6JOyJnRpZDhQItYn5VERxhL313C3J+k0pyEKGc2iJ3vEmmRXZvhx5HoSfU0HjDnrvtiq3gGlXHAH2rPu9J8MwTERehRYfBR/bNMg6Gfp2vTDrWcbcsmDYD5tMj8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W4CRDJX_1712618439;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W4CRDJX_1712618439)
          by smtp.aliyun-inc.com;
          Tue, 09 Apr 2024 07:20:42 +0800
Message-ID: <c94a62ab-00ff-46cb-b338-6c2a6258ba5f@linux.alibaba.com>
Date: Tue, 9 Apr 2024 07:20:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] erofs: use raw_smp_processor_id() to get buffer from
 global buffer pool
To: Sandeep Dhavale <dhavale@google.com>
References: <20240408215231.3376659-1-dhavale@google.com>
 <3b3d0b99-f7b5-4dcc-a631-1018f4025acf@linux.alibaba.com>
 <CAB=BE-Rk_Rxd6aNP99m=tSMt4-tNH4xKru8f1QeOF5fzd8-Mtg@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAB=BE-Rk_Rxd6aNP99m=tSMt4-tNH4xKru8f1QeOF5fzd8-Mtg@mail.gmail.com>
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
Cc: syzbot+27cc650ef45b379dfe5a@syzkaller.appspotmail.com, kernel-team@android.com, linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>, Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/4/9 07:05, Sandeep Dhavale wrote:
>>
>> Thanks for catching this, since the original patch is
>> for next upstream cycle, may I fold this fix in the
>> original patch?
>>
> Hi Gao,
> Sounds good. As the fix is simple, it makes sense to fold it into the
> original one.
> 
> Thanks,
> Sandeep.

Thanks, folded.

Thanks,
Gao Xiang
