Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DE49E116D
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 03:41:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y2PzK5y53z301x
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 13:41:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733193660;
	cv=none; b=iiYzmAO20yEJp2oc8sP/Zk+LcjY+tvgXtt5SrAJbPwqm1PFCKTEhm4Ghqtfwjpk2SM9ilibGQVzHPX/RfA6mrt1qWkZ5/wvvA/MLpL84yMI4q6BKOrtLQiilPkOgwelvKq6olGrnJpkS9OiGwzxf26baD4pJUwCNRohcrxgfRZ8OwG3km9kilNlJcBm9RivvhDZf0XcA0T0+XNmhkxatLM6E5f1cUyeuzMuhUNdV4DeA/p6yqxjrOz0YflsRBRWnThT8geMOBK8rYYUKGEe7BM5s1FEFjnU+QQ3CJgdKiegip9N+JxUL47JJqgksPruIcU03h+RqWMOCZxtIFsxgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733193660; c=relaxed/relaxed;
	bh=cOS7Bre2FnIZLB610BXielaQRRpp/ikbJgIMSajPh3s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=d/AkWWF/n4qrUhStoJfAefrK9wBPq/JbxWWdghZTgt6Nx6Vw/jiNooj2mEgJ29kqjURz2/IBZxfsIcdSRT8Dkql/bHMKoaDWtuax7L/2QZtB5rCstZ4p/V7vroyaKz8fnZXYNGfkPOhOxzwHvQTX3Nx7wQDst/CjQkkAyBaDtVx1Pa6F0HO/0ZgWF/ucM0DI6vONY6e0sXsL9nJs1a+eVU8Scg1XFw18x3hw5HyW7EZcdI6cDonHZWLd6gWdj7vDGyYKWgt6E0328z4VilrYl1f4YyC0b7xVT+as/t1W6KzhBfrq0feF7x4gPr01WDvZmpaCMaINpLOBnSHdRX62qw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Sj6jFOB6; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Sj6jFOB6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y2PzG31llz2xtK
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Dec 2024 13:40:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733193652; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=cOS7Bre2FnIZLB610BXielaQRRpp/ikbJgIMSajPh3s=;
	b=Sj6jFOB6Xya0hYdZ8idBrqoMt08g4dheZXz5JKBYASmWR5q5rj5iTBT/cXBxgdkwTY+50neof/A7P2hW1HijNLETts41zSKmiWwsoRMKqQMCJRnPc1XDSx1MBcfT0qi1O+pcF5zFFLnv9rVrR5oJGQwZJAJJClLTXVKlwS47Mhs=
Received: from 30.221.129.129(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WKl-jJM_1733193650 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Dec 2024 10:40:51 +0800
Message-ID: <6787d09b-4930-4e7c-a2c6-5bda0c78c926@linux.alibaba.com>
Date: Tue, 3 Dec 2024 10:40:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs-utils: mkfs: use scandir for stable output
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Jooyung Han <jooyung@google.com>
References: <20241203002720.3634151-1-jooyung@google.com>
 <a5b7aaf8-4b94-44dd-9bff-8e12080a8063@linux.alibaba.com>
 <CAO-8PLbD1hbRW24Xu+kJ6Ak9JZ+508sYgMa1oDB1PQ77YUptXg@mail.gmail.com>
 <b47f5ed4-dfe8-4ecd-b69e-4907f3a1e04d@linux.alibaba.com>
In-Reply-To: <b47f5ed4-dfe8-4ecd-b69e-4907f3a1e04d@linux.alibaba.com>
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



On 2024/12/3 10:36, Gao Xiang wrote:
> 
> 
> On 2024/12/3 10:20, Jooyung Han wrote:
>> Hi Gao,
>>
>> I found that in the loop erofs_iget_from_srcpath() is called in
>> different order due to readdir and erofs_iget_from_srcpath() calls
>> erofs_new_inode() which fills i_ino[0] for newly created inode. I
>> think this i_ino[0] having different values caused the difference in
>> the output.
> 
> Oh, okay, that makes sense, I think we'd better move
> 
> inode->i_ino[0] = sbi->inos++;  /* inode serial number */
> 
> to erofs_mkfs_dump_tree()  (since we'd better to leave
> i_ino[0] stable even without dumping from localdir later.)
> and even clean up a bit.
> 
> If you don't have more time to clean up this, let's just
> commit a patch to fix this directly.

Actually I think `erofs_prepare_inode_buffer()` is a good place
to fill i_ino[0], since it will stablize the exact physical
place of an on-disk inode.

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang

