Return-Path: <linux-erofs+bounces-2317-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DXJqMD3Kj2ntTgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2317-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Feb 2026 02:05:01 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A4D13A5CC
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Feb 2026 02:05:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fCW6K6wkCz2xln;
	Sat, 14 Feb 2026 12:04:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771031097;
	cv=none; b=Oi4U+uWg72nBfBZVoBCDEozBDZSFYD3J90MkgTvq/ku+Cko1c+hwAyishonrC1VLQ5vCB1zEWCILptnZRLws5UPLjPjXO+fqwl+/5N/XUwq/adwTd3QAt/rxlvi9OBV2AuzdpVbphCmJuA+62WABkFKYsCJT27ZQpiI+RzwOvEE7Wv4MVU4Bqm5cXm0GZQOMCo4/RSRYiQXjQQztULujNzUtfWlRgOuYUlOmJ5B9FIZWya6WYpN8R/IhgXGxWDNcbR0OOW3H9BZNw1PkzcJANngAwn9io2ECiRFSmT7HpnQaRffZHrCxK6qz2/gMV0L22/d6/FU9bxLnjq5HuLWbsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771031097; c=relaxed/relaxed;
	bh=b8jpKimESx6PTjh1R8HBGFIOfiD1ZYYbNxc4mg8sUxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=dLkKBXtMFN3/bxzkNBq4Espn7X6YY7B9BzjoEgbZi7C0z9Cs3Og7xxdz0RIbo87APsh3bojJNDG/gnkoNQHplDKzmjCEnUMlTllrf6w3ljLSUzbLoNjkFLCTbrcWx18gpFChxesiQDnZ329BYlTlaV31Sgw0vaw4hgIclblIozO11DuNzWst9rcXMM763RUKevZMGBQvh5NcqkFa9EOuFFSBLYKF0MF78Jtudg+M+syOZ+mZ/MOHqwhOJE39frcAqHxwhLqtzOF0irTufbxTMjepj13kCdMd+rCzOM3uJKEBia6i58pznZIop2ktTQaLcCmZ6fRKnmH2SVnIcn27Fg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=JFU45E0k; dkim-atps=neutral; spf=pass (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=JFU45E0k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fCW6H15jZz2xSF
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Feb 2026 12:04:52 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=b8jpKimESx6PTjh1R8HBGFIOfiD1ZYYbNxc4mg8sUxE=;
	b=JFU45E0kfomb8J/BbVltQXIzVybu4oSLohBviveEztAUfCyY+2KLj/4i2BG2tdsjqQGsr7xSD
	6X6+POroXpSPNMV28pUASz7eLTNNTA8xMGFG2zg4Kx1UvoVBX38o4TuKsBtxu60HgW//hWDKAIh
	6dYs5BErJPbb5mC6cHjVeLs=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fCW0c5CjDz12LDJ;
	Sat, 14 Feb 2026 09:00:00 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id CE3D42012A;
	Sat, 14 Feb 2026 09:04:47 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 14 Feb 2026 09:04:47 +0800
Message-ID: <c1cbb47f-2d18-4bf9-9c56-a6bbb3c1ed0f@huawei.com>
Date: Sat, 14 Feb 2026 09:04:46 +0800
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
Subject: Re: [PATCH] erofs: allow sharing page cache with the same aops only
To: <xiang@kernel.org>
References: <20260213073345.768320-1-lihongbo22@huawei.com>
 <aY-zU-R52VrbhGpL@debian>
Content-Language: en-US
CC: <chao@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <hsiangkao@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <aY-zU-R52VrbhGpL@debian>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	TAGGED_FROM(0.00)[bounces-2317-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_SENDER(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:chao@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:hsiangkao@linux.alibaba.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	MID_RHS_MATCH_FROM(0.00)[];
	HAS_XOIP(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim]
X-Rspamd-Queue-Id: 36A4D13A5CC
X-Rspamd-Action: no action



On 2026/2/14 7:27, Gao Xiang wrote:
> Hi Hongbo,
> 
> On Fri, Feb 13, 2026 at 07:33:45AM +0000, Hongbo Li wrote:
>> Inode with identical data but different @aops cannot be mixed
>> because the page cache is managed by different subsystems (e.g.,
>> @aops for compressed on-disk inodes cannot handle plain on-disk
>> inodes).
>>
...
>>
>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>> index 4f86169c23f1..5b05272fd9c4 100644
>> --- a/fs/erofs/inode.c
>> +++ b/fs/erofs/inode.c
>> @@ -254,7 +254,8 @@ static int erofs_fill_inode(struct inode *inode)
>>   	}
>>   
>>   	mapping_set_large_folios(inode->i_mapping);
>> -	return erofs_inode_set_aops(inode, inode, false);
>> +	inode->i_mapping->a_ops = erofs_get_aops(inode, false);
>> +	return IS_ERR(inode->i_mapping->a_ops) ? PTR_ERR(inode->i_mapping->a_ops) : 0;
> 
> I hope there is an aops variable instead of assigning
> inode->i_mapping->a_ops directly.
> 

Ok, thank you.
>>   }
>>   
>>   /*
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index d1634455e389..764e81b3bc08 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -471,26 +471,24 @@ static inline void *erofs_vm_map_ram(struct page **pages, unsigned int count)
>>   	return NULL;
>>   }
>>   
>> -static inline int erofs_inode_set_aops(struct inode *inode,
>> -				       struct inode *realinode, bool no_fscache)
>> +static inline const struct address_space_operations *
>> +erofs_get_aops(struct inode *realinode, bool no_fscache)
>>   {
>>   	if (erofs_inode_is_data_compressed(EROFS_I(realinode)->datalayout)) {
>>   		if (!IS_ENABLED(CONFIG_EROFS_FS_ZIP))
>> -			return -EOPNOTSUPP;
>> +			return ERR_PTR(-EOPNOTSUPP);
>>   		DO_ONCE_LITE_IF(realinode->i_blkbits != PAGE_SHIFT,
>>   			  erofs_info, realinode->i_sb,
>>   			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
>> -		inode->i_mapping->a_ops = &z_erofs_aops;
>> -		return 0;
>> +		return &z_erofs_aops;
>>   	}
>> -	inode->i_mapping->a_ops = &erofs_aops;
>> -	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && !no_fscache &&
>> -	    erofs_is_fscache_mode(realinode->i_sb))
>> -		inode->i_mapping->a_ops = &erofs_fscache_access_aops;
>>   	if (IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) &&
>>   	    erofs_is_fileio_mode(EROFS_SB(realinode->i_sb)))
>> -		inode->i_mapping->a_ops = &erofs_fileio_aops;
>> -	return 0;
>> +		return &erofs_fileio_aops;
>> +	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && !no_fscache &&
>> +	    erofs_is_fscache_mode(realinode->i_sb))
>> +		return &erofs_fscache_access_aops;
> 
> Can you rearrange it as
> 	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && !no_fscache &&
> 	    erofs_is_fscache_mode(realinode->i_sb))
> 		return &erofs_fscache_access_aops;
> 	if (IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) &&
> 	    erofs_is_fileio_mode(EROFS_SB(realinode->i_sb)))
> 		inode->i_mapping->a_ops = &erofs_fileio_aops;
> 	return &erofs_aops;
> 
Ok, they are equal. Since the EROFS in fscache mode can be fileio mode. 
And I will rearrange it in next version.

Thanks,
Hongbo

> ?
> 
> Thanks,
> Gao Xiang
> 

