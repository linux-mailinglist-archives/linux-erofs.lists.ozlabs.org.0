Return-Path: <linux-erofs+bounces-290-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDA2AAD5CF
	for <lists+linux-erofs@lfdr.de>; Wed,  7 May 2025 08:15:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZslP44ksZz2ymg;
	Wed,  7 May 2025 16:15:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.191
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746598520;
	cv=none; b=gMuK3faqij+TYRaQsdkwwSPRYvTUlkkPzySR7RsoYPi2t8u8EZQIqlSWje5DCJMNxtJ7FQhlp5az6jYYN6T8ylg2XWn6fxeQcYSoJ56KbZ/jMGEiQmPjCU7EhqFEHmFah93xRn0tn3SgXs94ScvEaKsKWAk+dmNUGzmOBOnvR7sDWgSL4pmDlxsMYLv1A/NAuJv5ASedftEQMvYaHfL3dQYRUugTP2FU9l9l9Ybf+9UdwB15QFMfpnW9ZLIUpaMfTOksnVSpTYEe4YZmz6AivCa60qwXk+JWMg0zwXKgw6RqKFi7GZSxYMb5aHYQUc6qmdDkGw+mWTE60Go99RJvVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746598520; c=relaxed/relaxed;
	bh=ryj5zxaIIhVI6bR/IDoSekAENp/t8nrBKO/kTEpCeT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UM6AZHtPKjy+QHQVTh1DuAnU7tHfe4qeJw/TEt4ccK5WO3V93cv+vHqj6orynJFDB6KTkCln5REC56X/mI6bplbYe3Bs/m1n2LtLKF4sOkKXxyTn2X+mINfuK+2Bk/qmjMt7WbetaceLZaO+GI2Lb6QEgBhLx7wCSDhLIy6C8H4dDNFcsPuxBdNe+Kf2gPlG6YLVEbOaEgzB7KrbS6mqxuoJFscB04r/F72b4/NLIXArTxNYf7Uz1Tu5uoP8RHFvjQ0XCgF6ZDC3kZ5/1JfrF7mIwHfleujOK/fKKbCaHPL23A5v6zPXvk3vVqadyU5HK7j2pNyKSm/C/5ynYlSFJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZslP30vzwz2ydl
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 May 2025 16:15:17 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZslLV1kzgz1R7Yj;
	Wed,  7 May 2025 14:13:06 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 21A4F140113;
	Wed,  7 May 2025 14:15:12 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 May 2025 14:15:11 +0800
Message-ID: <40f2f891-bd09-4600-9540-b6e6fa977958@huawei.com>
Date: Wed, 7 May 2025 14:15:10 +0800
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
Subject: Re: [PATCH v3] erofs: fix file handle encoding for 64-bit NIDs
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <xiang@kernel.org>,
	<chao@kernel.org>, <zbestahu@gmail.com>, <jefflexu@linux.alibaba.com>
CC: <dhavale@google.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
References: <20250429134257.690176-1-lihongbo22@huawei.com>
 <18d272ce-6a80-4fdc-b67b-ddc2ffa522d4@linux.alibaba.com>
 <3e068311-9223-4c1b-9091-15eb2d867ede@huawei.com>
 <1151f059-fd08-4dba-9448-c8c535ea8700@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <1151f059-fd08-4dba-9448-c8c535ea8700@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/5/7 10:42, Gao Xiang wrote:
> 
> 
> On 2025/5/7 09:53, Hongbo Li wrote:
>>
>>
>> On 2025/5/6 23:10, Gao Xiang wrote:
>>> Hi Hongbo,
>>>
>>> On 2025/4/29 21:42, Hongbo Li wrote:
>>>> In erofs, the inode number has the location information of
>>>> files. The default encode_fh uses the ino32, this will lack
>>>> of some information when the file is too big. So we need
>>>> the internal helpers to encode filehandle.
>>>
>>> EROFS uses NID to indicate the on-disk inode offset, which can
>>> exceed 32 bits. However, the default encode_fh uses the ino32,
>>> thus it doesn't work if the image is large than 128GiB.
>>>
>> Thanks for helping me correct my description.
>>
>> Here, an image larger than 128GiB won't trigger NID reversal. It 
>> requires a 128GiB file inside, and the NID of the second file may 
>> exceed U32 during formatting. So here can we change it to "However, 
>> the default encode_fh uses the ino32, thus it may not work if there 
>> exist a file which is large than 128GiB." ?
> 
> Why? Currently EROFS doesn't arrange inode metadata
> together, but close to its data (or its directory)
> if possible for data locality.
> 
> So NIDs can exceed 32-bit for images larger than
> 128 GiB.
> 

Ok, I see your point, and you are right. It doesn't have to be a 128GiB 
file, but it is easy to construct this kind of EROFS image by large 
file. Such as:

mkfs.erofs -d7 --tar=f --clean=data foo.erofs 128g-file.tar  # the nid 
of 128g-file is 39.
mkfs.erofs -d7 --tar=f --incremental=data 1b-file.tar  # the nid of 
1b-file is 4294967425.

Thank you again for your review, I will send the next version of the 
patch later.

Thanks,
Hongbo

> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>> Hongbo
>>
> 

