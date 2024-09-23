Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3848197E58C
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 07:03:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XBrV85rXyz2yVX
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 15:03:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727067790;
	cv=none; b=WsyptqrZZuASJ3nH4Mxs5q0DpEmiSxeN3+w2VCtqb4B4Nk1pMm31WElICW1uwDvIRWBE2twRX/WF77dXeg9Mqk9OKaXPvKqbxSBYWlAFyT/d/Td5LQQydKP9ENfTVv2PwZnQoeeEoVr/t0X7UmE3MHu2oru4s2W6mCQOSpWGLn1A5tvehT1sdYG2Ob9oMrmuWGUg4e48kTSQiNDwyHJzvVRIsoZt3AO3Dgx9DxLmSGitjAJCFQYDYRvBDB0Tu7hlio7RZ8HYtjpsfiLVO7DEx0wF/dO92lJDE072AsrWjJO8LWyb2alJQfw+JIl1LBHUgfh4fPJ/Cm4b/FTdRxOToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727067790; c=relaxed/relaxed;
	bh=CRs+ga/kbccjt1rLHqhwLJaB7c0fWVlLgSyriF+hKAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eWx1SfRdrv3JTcVi+YEzngIctU/Thalt9orBlDsXIPvXMUsvSMdcjRrVPcNRftpMbDvPkWnhnqT3MapENYGsjOUMo8gLtXgWPyKCfSXLfG5+jaMZf8HCFwuNMMZwsL5KJ7oU71vhzl2OIIGcRcN20M+ppy3rt8ctinl8VHm133lEwL0a24ZDZ6Gt/RvVmQ7i3WXn4XpEE0Spo6kvlP3oa10VLj51oQ9m4gieY4NyjVPoasEl68OXQN/AZKs+AS7/Vpl/vQIny/YwNCksmNWpqubDm1ZPYIvanDYN8U/H8QeCS24uL09yAmqsUmQkUO1pjBVBYqbmaytFQB0PoOvlUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LZcAFB3p; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LZcAFB3p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XBrV50XbLz2xJ5
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Sep 2024 15:03:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727067781; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CRs+ga/kbccjt1rLHqhwLJaB7c0fWVlLgSyriF+hKAk=;
	b=LZcAFB3pVu7PGA7P0ePmOL5pdUlnPv/franqzFbsixwLdBFpLAkQ9ilfJcEI5hJR1pxH9+fwQ/W3NOSnpn73fRfXGCwaURfWZpqcn8n/2a/b85m0NStqTmhVLtFeXDWjOdtO2p0LqpJVqbYA/LpxAdhSg+yLXhRIcVbrG87OkyM=
Received: from 30.27.108.50(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFSQeIm_1727067778)
          by smtp.aliyun-inc.com;
          Mon, 23 Sep 2024 13:02:59 +0800
Message-ID: <fe4b917e-9ddf-47f4-84df-f02256e0d62f@linux.alibaba.com>
Date: Mon, 23 Sep 2024 13:02:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: fix compressed packed inodes
To: Danny Lin <danny@orbstack.dev>
References: <20240916073835.77470-1-danny@orbstack.dev>
 <CAEFvpLe92-nS+4zOv5a=UOMW2whBtsGZ98D_MHv+x_KujEaroQ@mail.gmail.com>
 <63307dbc-da27-42e6-86fb-ed446f04ede5@linux.alibaba.com>
 <2ada73ab-66c2-437c-bbc2-fd07cb42c265@linux.alibaba.com>
 <CAEFvpLcEKEhRVCDggHbmFeFJQqte_8BWAyc-40e4TZJPEQTUhA@mail.gmail.com>
 <CAEFvpLeBDf_BjwJJRc3Ecn7DMZNkFYsAri6=dy7ERQ2SFLmhFA@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAEFvpLeBDf_BjwJJRc3Ecn7DMZNkFYsAri6=dy7ERQ2SFLmhFA@mail.gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Danny,

On 2024/9/23 12:36, Danny Lin wrote:
> On Sun, Sep 22, 2024 at 9:30 PM Danny Lin <danny@orbstack.dev> wrote:
>>
>> On Sun, Sep 22, 2024 at 8:03 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>>
>>> Hi Danny,
>>>
>>> On 2024/9/23 08:08, Gao Xiang wrote:
>>>> Hi Danny,
>>>>
>>>> Thanks for the patch!
>>>> Sorry I somewhat missed the previous email..
>>>>
>>>> On 2024/9/22 13:08, Danny Lin wrote:
>>>>> Gentle bump — let me know if anything needs to be changed!
>>>>
>>>> Does the following change resolve the issue too?
>>
>> Thanks for the suggestion. I tried your patch and it segfaults instead.
> 
> I think the segfault is because it returns ERR_PTR(0) instead of inode
> on success. That should be an easy fix but we'd still be skipping
> erofs_prepare_inode_buffer and erofs_write_tail_end.

Yeah, correct, thanks for catching! so I think just?

@@ -1927,7 +1926,9 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_sb_info *sbi,

                 DBG_BUGON(!ictx);
                 ret = erofs_write_compressed_file(ictx);
-               if (ret && ret != -ENOSPC)
+               if (!ret)
+                       goto out;
+               if (ret != -ENOSPC)
                          return ERR_PTR(ret);

                 ret = lseek(fd, 0, SEEK_SET);
@@ -1937,6 +1938,7 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_sb_info *sbi,
         ret = write_uncompressed_file_from_fd(inode, fd);
         if (ret)
                 return ERR_PTR(ret);
+out:
         erofs_prepare_inode_buffer(inode);
         erofs_write_tail_end(inode);
         return inode;

> 
>>
>>  From a quick glance at the surrounding code, it doesn't seem correct
>> because the calls to erofs_prepare_inode_buffer and
>> erofs_write_tail_end are skipped if ret == 0.
>>
>>>>
>>>> Also I think it
>>>> Fixes: 2fdbd28ad4a3 ("erofs-utils: lib: fix uncompressed packed inode")
>>
>> Ah, nice catch. Do you want me to resubmit or will you fix it when
>> applying the patch?

Could you please resubmit since you're credited on this?

Thanks,
Gao Xiang
