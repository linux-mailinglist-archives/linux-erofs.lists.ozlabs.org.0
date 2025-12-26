Return-Path: <linux-erofs+bounces-1613-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF56CDE752
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Dec 2025 08:51:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dcyVs3Rmzz2xg9;
	Fri, 26 Dec 2025 18:51:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766735509;
	cv=none; b=D6/eoNvU+FY/MHIE+QEC2IdhUe3F3fPYSY5FSDg5EQKWUT2Xs/901xI3vAwdAEq6/Mr8/wlhwdTvLBxBP3upTyuMNPqkQ8ZtRH7qq46n6ZYgFr5sSyG0bAnhERKcqAwojQ2bgDZQm6rflGz67kVfBjtnenxYojlowdco4MFokSJvJQ0GtIpq16GTPC6+hETgZ8ZrQjNPn0s5vkm3ykQtchC0qo+Zt4hLLGW8lThfSEAPvZdqDH9c5Hctn1+LJrzuU/Ehb1OnDvbT34PG4cUqoApgsmBlWps5A0Alv0zR+Wnxs5EWb28aLsAvJc5VmcdbCUUydOhD4pOOODz7qdqOLw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766735509; c=relaxed/relaxed;
	bh=Qd9rfpmNR9JZnpm0KlG2esdNFpGHbXKboYyu5igtky0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gE0krFXFtUiKU6kApb5Aa78YvZ0PFjve72ohYYHU1jiBw5R4p47ImEFXuAPgNVTh9RENfx63aikvqGm9QdcfTFAX5w2LevHDpGWfkxPKIpBws36QN06gm0CDs79C7SeqcHOizstYjyPYbaWtI/ONwgvgg3qJxsO74RfllaVBSPjBsldAyVM3oh5D65Gho+paaMHa7RzdMC8ai0snJs9KQyCbJuAch0rdeiOs7mCG8o6ZDDTzL6DCbsxl+WpkxqjTSzchkIQA7Ch+cyrafUJXJODUiUQPeVZeR7c0GHHXpXi98I7W/I6wjcrI3xgfUdmzhM0blUSE5xFQHOVXiMyQUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Pqt2Hp7B; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Pqt2Hp7B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dcyVp3Mx6z2xcB
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Dec 2025 18:51:43 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766735494; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Qd9rfpmNR9JZnpm0KlG2esdNFpGHbXKboYyu5igtky0=;
	b=Pqt2Hp7Bt4rBEAA+x4sQJq3pSCai3VTMQRSA2uAY2DDV44rnskS9r+4uF386PWsBcl9jNT24w+xtNg1xsWdQUB8u32tagfcyBFpPwNH97OBy9iw4MgT+OqFunHi++D2BarEJ6aaQ/M3209Zj9XgDj02jpSxRtW0Wqh+rQpKVZAc=
Received: from 30.221.133.83(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wvgwauo_1766735492 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 26 Dec 2025 15:51:33 +0800
Message-ID: <7f954197-0027-4a4d-b237-ba5a0f09fe8f@linux.alibaba.com>
Date: Fri, 26 Dec 2025 15:51:32 +0800
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
Subject: Re: [PATCH 4/5] erofs-utils: mount: gracefully exit when
 `erofsmount_nbd()` encounts an error
To: "zhaoyifan (H)" <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: jingrui@huawei.com, wayne.ma@huawei.com
References: <20251223100452.229684-1-zhaoyifan28@huawei.com>
 <20251223100452.229684-3-zhaoyifan28@huawei.com>
 <6571a348-0e96-4c79-91fc-278dbfb2a54a@linux.alibaba.com>
 <ab5d631a-ec99-4c1b-a071-e1b5168880d9@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ab5d631a-ec99-4c1b-a071-e1b5168880d9@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/26 15:43, zhaoyifan (H) wrote:
> 
> On 2025/12/26 14:49, Gao Xiang wrote:
>>
>>
>> On 2025/12/23 18:04, Yifan Zhao wrote:
>>> If the main process of `erofsmount_nbd()` encounters an error after the
>>> nbd device has been successfully set up, it fails to disconnect it
>>> before exiting, resulting in the subprocess not being cleaned up and
>>> keeping its connection with NBD device.
>>>
>>> This patch resolves the issue by disconnecting NBD device before exiting
>>> on error.
>>>
>>> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
>>> ---
>>> Note:
>>> - I believe directly killing the child process is unsafe, as it may leave
>>> in-flight NBD requests from the kernel unhandled, causing soft lockup.
>>> - And I believe using nbdpath here is safe, as the child process maintains
>>> the NBD device connection throughout, preventing concurrent access by other
>>> actors.
>>
>> What if the child process is already exited earlier, and the current NBD
>> device is reused for others?
>>
>> How about keeping the previous nbdfd for ioctl interfaces instead to
>> avoid nbd device reuse.
>>
> OK, I will try this way.

Can you move small fixes in advance, and leave refactering at last?

Thus we could address these small fixes first.

Thanks,
Gao Xiang

> 
> 
> Thanks,
> 
> Yifan
> 
>> Thanks,
>> Gao Xiang
>>
>>>
>>>   mount/main.c | 17 +++++++++++++++--
>>>   1 file changed, 15 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mount/main.c b/mount/main.c
>>> index 2a21979..d2d4815 100644
>>> --- a/mount/main.c
>>> +++ b/mount/main.c
>>> @@ -1287,10 +1287,23 @@ static int erofsmount_nbd(struct erofs_nbd_source *source,
>>>         if (!err) {
>>>           err = mount(nbdpath, mountpoint, fstype, flags, options);
>>> -        if (err < 0)
>>> +        if (err < 0) {
>>>               err = -errno;
>>> +            if (msg.is_netlink) {
>>> +                erofs_nbd_nl_disconnect(msg.nbdnum);
>>> +            } else {
>>> +                int nbdfd;
>>> +
>>> +                nbdfd = open(nbdpath, O_RDWR);
>>> +                if (nbdfd > 0) {
>>> +                    erofs_nbd_disconnect(nbdfd);
>>> +                    close(nbdfd);
>>> +                }
>>> +            }
>>> +            return err;
>>> +        }
>>>   -        if (!err && msg.is_netlink) {
>>> +        if (msg.is_netlink) {
>>>               id = erofs_nbd_get_identifier(msg.nbdnum);
>>>                 err = IS_ERR(id) ? PTR_ERR(id) :
>>


