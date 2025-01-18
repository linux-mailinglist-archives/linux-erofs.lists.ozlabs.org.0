Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F218A15AD4
	for <lists+linux-erofs@lfdr.de>; Sat, 18 Jan 2025 02:25:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YZf756ldnz3clL
	for <lists+linux-erofs@lfdr.de>; Sat, 18 Jan 2025 12:25:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2403:5800:3:25::1001"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737163537;
	cv=none; b=OgE1/JL4++HYQIgrDtyW9/vpW93Fu++giFUIYBRBYoK4PGBL2BS1e1+w4Ad0QTmkUxq1gdvacKb5nlOhirtXDH3yd8GMpPlc4QmlgOameDWJhobNnD3W5ZSoYHkXvBLHR+NuYG39b+F1rL0JLgU+6tJSLWzoZiw+9/Y0QaljgbL/KUkWnXCFDtVyFt0GO1fMDs7I7htA9bwLQ6Ws8MX6acfpWA1UCYxjeTzPbV+GjKQlnkFhFyXI2rdKFlUawbGJrd1tJ2ZlrE2qxw06l8gYmVF2aiCEgVqtNjHYCmcNQSURzFPi7I2/sEZAJR5uWJg99/QSCuZjjVdqXjSeKK9Vug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737163537; c=relaxed/relaxed;
	bh=6RWBjwCQMCBPfqKwLM5yv/tChABN1ezb2Eqd1URLcVg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZZnwH5TiuCSQEJ/D2wVYLTbVpfdi9Rvcqbdhpi1/JlAeucGBk5rA0AzpWEVGguaqCQ2/chc/Emdmcdz73J9AJZwBRezuTvVL9x9gBDpB6GMhrm7zLPZUaniHpeX//icXy08WQs+98hEWlNLYrDfMY3jKle3BbsUGSO4KVwiQJrVUCQCZN8MdPkxhKql6/0P8yWPyRAlZIkrMdJ+xysq/Z/l9L9ajyxhcMOh9Rv2E4QKY9dMky1EOm80/AQQV7Ce2FjndoTO6aHfMY1l/zNI2e24fcfrGO/hY6IboNPjwC2s3YYgBsK1qcmchYVjaD1B7Jwj3wQ6uTCCAhfMLYkWPmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=themaw.net; spf=neutral (client-ip=2403:5800:3:25::1001; helo=smtp01.aussiebb.com.au; envelope-from=raven@themaw.net; receiver=lists.ozlabs.org) smtp.mailfrom=themaw.net
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=themaw.net
Authentication-Results: lists.ozlabs.org; spf=neutral (access neither permitted nor denied) smtp.mailfrom=themaw.net (client-ip=2403:5800:3:25::1001; helo=smtp01.aussiebb.com.au; envelope-from=raven@themaw.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 2413 seconds by postgrey-1.37 at boromir; Sat, 18 Jan 2025 12:25:36 AEDT
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [IPv6:2403:5800:3:25::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YZf74644vz306S
	for <linux-erofs@lists.ozlabs.org>; Sat, 18 Jan 2025 12:25:36 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp01.aussiebb.com.au (Postfix) with ESMTP id 543581008CD
	for <linux-erofs@lists.ozlabs.org>; Sat, 18 Jan 2025 12:25:36 +1100 (AEDT)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
	by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4gtDuio5nM9f for <linux-erofs@lists.ozlabs.org>;
	Sat, 18 Jan 2025 12:25:36 +1100 (AEDT)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
	id 411C3100763; Sat, 18 Jan 2025 12:25:36 +1100 (AEDT)
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=5.0 tests=SPF_HELO_NONE,SPF_NEUTRAL
	autolearn=disabled version=4.0.0
Received: from [192.168.1.229] (159-196-82-144.9fc452.per.static.aussiebb.net [159.196.82.144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ian146@aussiebb.com.au)
	by smtp01.aussiebb.com.au (Postfix) with ESMTPSA id A2431100763;
	Sat, 18 Jan 2025 12:25:34 +1100 (AEDT)
Message-ID: <a9ab830c-241d-4a78-9909-9c986ad91741@themaw.net>
Date: Sat, 18 Jan 2025 09:25:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: add error log in erofs_fc_parse_param
From: Ian Kent <raven@themaw.net>
To: Chen Linxuan <chenlinxuan@uniontech.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>
References: <F2F43EB045D266E8+20250117085244.326177-1-chenlinxuan@uniontech.com>
 <9b2b5a34-cddd-41b2-9d1e-939b9f97b44b@themaw.net>
Content-Language: en-US
Autocrypt: addr=raven@themaw.net; keydata=
 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
In-Reply-To: <9b2b5a34-cddd-41b2-9d1e-939b9f97b44b@themaw.net>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 18/1/25 08:45, Ian Kent wrote:
> On 17/1/25 16:52, Chen Linxuan wrote:
>> While reading erofs code, I notice that `erofs_fc_parse_param` will
>> return -ENOPARAM, which means that erofs do not support this option,
>> without report anything when `fs_parse` return an unknown `opt`.
>>
>> But if an option is unknown to erofs, I mean that option not in
>> `erofs_fs_parameters` at all, `fs_parse` will return -ENOPARAM,
>> which means that `erofs_fs_parameters` should has returned earlier.
>
> I'm pretty sure than the vfs deals with reporting unknown options
>
> and returns -EINVAL already.
>
>
> I think the caller oferofs_fc_parse_param() is vfs_parse_fs_param()
>
> and for an -ENOPARAM return will ultimately do this:
>
> return invalf(fc, "%s: Unknown parameter '%s'", fc->fs_type->name, 
> param->key);
>
> which does this.
>
> The thing about this is the mount API macro deals with (or it should,
>
> although I'm not sure that's completely sorted out yet) logging the
>
> message to the console log as well as possibly making it available to
>
> mount api system calls. I'm pretty sure this change will prevent the
>
> error message being available for mount api system calls to retrieve.

Actually no, removing the default switch branch does look like the right 
thing

to do, my mistake. The call to fs_parse() will return -NOPARAM so the

switch doesn't need to handle that case.


Oops!

>
> Ian
>
>>
>> Entering `default` means `fs_parse` return something we unexpected.
>> I am not sure about it but I think we should return -EINVAL here,
>> just like `xfs_fs_parse_param`.
>>
>> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
>> ---
>>   fs/erofs/super.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 1fc5623c3a4d..67fc4c1deb98 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -509,7 +509,8 @@ static int erofs_fc_parse_param(struct fs_context 
>> *fc,
>>   #endif
>>           break;
>>       default:
>> -        return -ENOPARAM;
>> +        errorfc(fc, "%s option not supported", param->key);
>> +        return -EINVAL;
>>       }
>>       return 0;
>>   }
