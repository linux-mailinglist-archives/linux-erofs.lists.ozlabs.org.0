Return-Path: <linux-erofs+bounces-1856-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC68D1D27E
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Jan 2026 09:38:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4drfdj3yybz2xPB;
	Wed, 14 Jan 2026 19:38:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768379897;
	cv=none; b=Y+wXqcCKZjHpqkKiifcr/Qn7IV8HuUf7BiTIQxhfXtjhflOfFxROBVw6qnelk8P3d4NBZY94NweYVVXNYBQCtHPvSlu1sF7s9kZuPG3/JkkD2KZbAfnvhWQYRFIKpVQiDLHguSYkhEQkAdUuP3USgyFaUo4sWgr+8xeacSqxDmaS1vGzP6oFD3A9EcW/yuzadhFfgWlJRUgdrY5st43sYfqLM0Db1Vbqqsk13RZovF+65cZz1Wv9PKQeJcXDmG8OEUaUt+xGLeKMQBmSlRIkHfz20zjvsovYSTUSFdvD9VUNn1Vm1do8feSVaVZIDLMW3JAWubcnUHyyrged+NcBcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768379897; c=relaxed/relaxed;
	bh=MmUL2H2ZZup30W64gzMAnFdGh/d85wBZ7Ks5MAkpU9Q=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:CC:
	 References:From:In-Reply-To; b=PMzjSiyi9GRCRzB59MrSQPAAZLSqL31T3nPSaWmideIhaN65WV9mcCoUjbkqQ2RRtcRGiw4YfwyLZWNSPjFy42GHNuJ5dU/vqxnV27g/gn1Cjx0Kbpt+wGNPbpA1huGy/SRWdn3ar1woSVyW+5jJh5+WdLP3xVHDtb9K2XFchZAJqzWFGNdJPtSQDUnG4QjOoFA4MDPZkbZAMmCNBDq8hojqF5IS4tdSGWSx6L7pUjvwHOaVBrlqziRui4/LbCxCyX8t8cycaVsj/dx2TVlvThpULqkrs9+xHopxOSr6A+xEtl4VqY87ZpYsit6WtEeL8DKMbuvK6kimy9Y7nFWL8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=wI1FHNS2; dkim-atps=neutral; spf=pass (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=wI1FHNS2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drfdh0MZcz2xFn
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Jan 2026 19:38:15 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=MmUL2H2ZZup30W64gzMAnFdGh/d85wBZ7Ks5MAkpU9Q=;
	b=wI1FHNS2lMp4rTLTwYqVQyufhj97RdW3/dwcnvTHcr1DHOHqfgJnZqhETNThERBHDkAWxD/Sa
	RiX7V2CL1OXlRQRgUetli25MIGwBN9sOTY0WNUgm3sFSRNlHGn2QzOj6NXlf4MAZdKLDpj8tU2q
	XkeG3Q8GerFqYL9BIrm2CoI=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4drfYk65jzzmVCW;
	Wed, 14 Jan 2026 16:34:50 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A9D24055B;
	Wed, 14 Jan 2026 16:38:11 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 14 Jan 2026 16:38:10 +0800
Content-Type: multipart/alternative;
	boundary="------------hTmy2Nv5eCiee8WFIagoW1Yh"
Message-ID: <47c650f0-feb3-445b-97be-dff04fb6733a@huawei.com>
Date: Wed, 14 Jan 2026 16:38:09 +0800
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
Subject: Re: [PATCH v2] erofs-utils: lib: correctly set {u,g}id in
 erofs_rebuild_make_root()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <wayne.ma@huawei.com>
References: <7db44e77-9256-469d-9845-d40079ab2a5a@linux.alibaba.com>
 <20260114073806.3640681-1-zhaoyifan28@huawei.com>
 <1e1c7c27-abb5-4f6a-b27c-0f15b9e5da16@linux.alibaba.com>
 <0bc1baff-775b-4cf7-89f8-eaa22af10d9f@huawei.com>
 <8cda58e0-e917-4e9c-ae68-d34336deb446@linux.alibaba.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <8cda58e0-e917-4e9c-ae68-d34336deb446@linux.alibaba.com>
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

--------------hTmy2Nv5eCiee8WFIagoW1Yh
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/1/14 16:09, Gao Xiang wrote:

>>>     root->i_uid = params && params->fixed_uid < 0 ? getuid() :
>>>             params->fixed_uid;
>>
>> will sigfault if `params == NULL`, how about
>>
>>      root->i_uid = (!params || params->fixed_uid < 0) ? getuid() :
>>                                 params->fixed_uid;

Hi Xiang,

v3 patch sent, however I'm afraid we can't compare fixed_{u,g}id with 0,

as it's of an unsigned type. I've kept ` params->fixed_uid == -1` for now.


Thanks,

Yifan

>
> Sorry about my braino.
>
> Thanks,
> Gao Xiang



--------------hTmy2Nv5eCiee8WFIagoW1Yh
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>On 2026/1/14 16:09, Gao Xiang wrote:</p>
    <blockquote type="cite"
      cite="mid:8cda58e0-e917-4e9c-ae68-d34336deb446@linux.alibaba.com">
      <blockquote type="cite" style="color: #007cff;">
        <blockquote type="cite" style="color: #007cff;">    root-&gt;i_uid
          = params &amp;&amp; params-&gt;fixed_uid &lt; 0 ? getuid() :
          <br>
                      params-&gt;fixed_uid;
          <br>
        </blockquote>
        <br>
        will sigfault if `params == NULL`, how about
        <br>
        <br>
             root-&gt;i_uid = (!params || params-&gt;fixed_uid &lt; 0) ?
        getuid() :
        <br>
                                        params-&gt;fixed_uid; <br>
      </blockquote>
    </blockquote>
    <p>Hi Xiang,</p>
    <p>v3 patch sent, however I'm afraid we can't compare fixed_{u,g}id
      with 0,</p>
    <p>as it's of an unsigned type. I've kept ` params-&gt;fixed_uid ==
      -1` for now.</p>
    <p><br>
    </p>
    <p>Thanks,</p>
    <p>Yifan</p>
    <blockquote type="cite"
      cite="mid:8cda58e0-e917-4e9c-ae68-d34336deb446@linux.alibaba.com">
      <br>
      Sorry about my braino.
      <br>
      <br>
      Thanks,
      <br>
      Gao Xiang</blockquote>
    <p><br>
    </p>
    <p><br>
    </p>
  </body>
</html>

--------------hTmy2Nv5eCiee8WFIagoW1Yh--

