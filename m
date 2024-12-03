Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9CC9E13A2
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 07:58:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y2WhX1zCNz302W
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 17:58:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733209114;
	cv=none; b=OSqkUG2qKK9tldAWwgHQZOFp8+/dOcxXGBiUPCPMCaQm6LdWtLLXurHaXIX1xKJ18A+1k02qTtA8gz852Ph0PTdth5RO+bMnBFvO6QkuWkoSXWo78uNY766VPPzOadxYpHcORqIGS7UeNEwlWCKWsQmeErl1cH9SK2f+8T6DOrze5SWbVjTXBk2jNgNFJhbyn9/ouIpDIcjXoUTz/32P2J/SsZwRJC4DHn5/VXoVXYQkhKEMySjIBqdMDdWep171R6q4mcRWsPx99yFaiJp4yNc8k2XS79la2ySNE9IMcMti45I4oHNxSVRfHIFfPJUJIReWfFI8/yOwAKdMIDdAaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733209114; c=relaxed/relaxed;
	bh=bId1gcrU9ha9gcEWyob1wKtWlb1/yb0XlNMlj3aaoqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8hyxIB8jvpsF/TF68WJAjq6Je4kjAZHGlwlDSmAVVg3S4B4jXWnzSQ1vjRvciY2HxMRIB+kHr6I0Zcrnt8SnmgvPet8E/TuVr/NppC9o1qspLdtAWKlWBDIe8iXVPNKKtu3Cn0LWwA8MBhTDz6rDpRsGzmj2Is1Nu5mKdPlNnTq+T0BJgW9GvQLEgLyKVKZJKkoKaG3YhoKZhUQNpdhNn/dw/lSUcCL7cQXNSN/J9wAYlG1BfNFBOoEtwiH5uS58VqxLIREtBTpMQFjIsPHyhY0l8rWMTrh0QL6k3ocFtrupQkV7iZnl83Ef6WtAGt1B7JlWHzypJnjzwm7meBBfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wT2jCucl; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wT2jCucl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y2WhR36Hqz2xnK
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Dec 2024 17:58:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733209099; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bId1gcrU9ha9gcEWyob1wKtWlb1/yb0XlNMlj3aaoqM=;
	b=wT2jCuclP4h5RecmSg3kELH7EyIu75oREAM1k8KvtjseGvLzfG4XgHs3nOkZmhRD2JQELx93IlEc8O5o0r9swIAKE7sn4mhV/47BPFc8BIj8HlfS7wEvsevemcwJ1IWWOwK3+An3tr5e7Lb7GHQOf9GJHqIr/1f2q0vYlNBQnz8=
Received: from 30.221.129.129(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WKlixp6_1733209097 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Dec 2024 14:58:18 +0800
Message-ID: <c077161a-1a6a-4ab2-96ae-5b7f5fba802b@linux.alibaba.com>
Date: Tue, 3 Dec 2024 14:58:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs-utils: mkfs: use scandir for stable output
To: Jooyung Han <jooyung@google.com>
References: <20241203002720.3634151-1-jooyung@google.com>
 <a5b7aaf8-4b94-44dd-9bff-8e12080a8063@linux.alibaba.com>
 <CAO-8PLbD1hbRW24Xu+kJ6Ak9JZ+508sYgMa1oDB1PQ77YUptXg@mail.gmail.com>
 <b47f5ed4-dfe8-4ecd-b69e-4907f3a1e04d@linux.alibaba.com>
 <CAO-8PLYw-TM852eP1OBbixQUd+XGTReswfPXx41J3CMor-1YDg@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAO-8PLYw-TM852eP1OBbixQUd+XGTReswfPXx41J3CMor-1YDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/12/3 14:37, Jooyung Han wrote:
> (I forgot to reply all)

Yeah, I received that.

> 
> On Tue, Dec 3, 2024 at 11:36 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2024/12/3 10:20, Jooyung Han wrote:
>>> Hi Gao,
>>>
>>> I found that in the loop erofs_iget_from_srcpath() is called in
>>> different order due to readdir and erofs_iget_from_srcpath() calls
>>> erofs_new_inode() which fills i_ino[0] for newly created inode. I
>>> think this i_ino[0] having different values caused the difference in
>>> the output.
>>
>> Oh, okay, that makes sense, I think we'd better move
>>
>> inode->i_ino[0] = sbi->inos++;  /* inode serial number */
>>
>> to erofs_mkfs_dump_tree()  (since we'd better to leave
>> i_ino[0] stable even without dumping from localdir later.)
>> and even clean up a bit.
>>
>> If you don't have more time to clean up this, let's just
>> commit a patch to fix this directly.
> 
> Sounds good to me ;-)
> To be honest, I don't know the stuff well enough for this cleanup.

Ok, anyway if you could submit a patch that moves
inode->i_ino[0] = sbi->inos++;
from erofs_new_inode() to erofs_prepare_inode_buffer()

I will apply directly.

Also I'd like to update it as
inode->i_ino[0] = ++sbi->inos;

Since `i_ino == 0` is invalid...

Thanks,
Gao Xiang

> 
>>
>> Thanks,
>> Gao Xiang
> 
> Thanks,
> Jooyung

