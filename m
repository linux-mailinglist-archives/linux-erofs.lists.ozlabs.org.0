Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C32A2BED4
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Feb 2025 10:11:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yq7Vt4PZXz30VL
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Feb 2025 20:11:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738919460;
	cv=none; b=HXalUx0IOHoa+f66D8YlPaaysULwIw917+SKrN5fMyQwqR97qOPPUz7vbHvApsVUGZt6+VkTSRis9AMsXECsislyk4fYjRikv4to8uHb0cTliyas2pPmZ0zKb2XW+52NeWUM2GYOZh+Jc3uWIpOplhqz3ZgrCPO8pPhe5ZGpt3BJ8F/Pa1DMrHaGzrkERM339GiD2McEyk6piaE7f8KzfzXusaTzSr4egL5ISxSamwkzKZE/QKwdXNgRugkXcxllG8tMglCTRI6Nbh+Ofr/tY4gsme4oAHdPHhksBhUqaRa2Q+RxKU1hYBHEGoFyn2a8yVf4XFZ2B0mOhvKFKww6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738919460; c=relaxed/relaxed;
	bh=srTohFrkLUWkNmQn0i+d/kVtXnoicbZijIYddqpXBbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G3FGrbfPc5iQbo6P+hSU3QnCe35h32fiAGsJhNwwsmR1SVx8XQ/68KNGjDhza1qidpLQMHi32zcnVXeCXoFbLu+XHlIWo8RGykqV56mFd5X+w1P82gqbuYjUZ6KGAdCGFqnLdGJFOfCCvSrNAa77LFQhdplYlOh5cFpe2oFaL4dKYpnv6ReqxZY7QyKGdXozI8tdJxCZLe7a2cACYc3g3vV6/jIAUs2gUvrTYsgB/h3zQYPdlLO/+D2P4tBJIMvAkayHp9p2ehaqZFy8T8HZyZ8XOtprFnioUZ3vgyAchPRmZkxupECgqmfnxXp+SrU/ogz7J4fe5+1r0OwopZeMag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OzRoIq2O; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OzRoIq2O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yq7Vp5TCFz2y66
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Feb 2025 20:10:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738919453; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=srTohFrkLUWkNmQn0i+d/kVtXnoicbZijIYddqpXBbA=;
	b=OzRoIq2OMJVFwsrDsxQiTVk+aAYbiF1tpq+6TfoKUvY5ZGsQC0plfNx2QP6hy8KFuDWz742oTYRybGnajkAZvuWbfUufR7fmz6LvgP3BBmbuEgGBph2vW+KLjYph1qTx65IUO7gpmphAeMcBSjNbpl/e/lq3bvOKn12MFkERn08=
Received: from 30.74.129.145(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WOyyqss_1738919452 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Feb 2025 17:10:52 +0800
Message-ID: <c1a59a9b-2fc1-426e-99e0-26380fcbb4de@linux.alibaba.com>
Date: Fri, 7 Feb 2025 17:10:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify
 switches
To: Hongbo Li <lihongbo22@huawei.com>,
 Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250207080829.2405528-1-hongzhen@linux.alibaba.com>
 <f4319592-df8f-4468-b8fb-7fcbc51804c6@linux.alibaba.com>
 <10e648ae-7e0b-4560-a73d-b728efbc9e15@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <10e648ae-7e0b-4560-a73d-b728efbc9e15@huawei.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Hongbo,

On 2025/2/7 16:57, Hongbo Li via Linux-erofs wrote:
> 

...

>>> @@ -329,35 +328,31 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>>>       DBG_BUGON(lcn == initial_lcn &&
>>>             m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD);
>>> -    switch (m->type) {
>>> -    case Z_EROFS_LCLUSTER_TYPE_PLAIN:
>>> -    case Z_EROFS_LCLUSTER_TYPE_HEAD1:
>>> -    case Z_EROFS_LCLUSTER_TYPE_HEAD2:
>>> +    if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
>>> +        erofs_err(sb, "cannot found CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
>>> +        DBG_BUGON(1);
>>> +        return -EFSCORRUPTED;
>>> +    }
>>
>> No, I don't think it's equivalent, please use
>> the previous version for this part instead.
> 
> I think this version doesn't consider the fallthrough case. May be just use the goto statement can keep equivalent.

For this particular part, I tend to use the first
version since it's already simple enough anyway.

Thanks,
Gao Xiang

> 
> Thanks,
> Hongbo
> 
>>
>> Thanks,
>> Gao Xiang

