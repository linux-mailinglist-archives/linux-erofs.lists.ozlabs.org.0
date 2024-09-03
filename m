Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC7996961B
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Sep 2024 09:52:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WydBM4dLMz2yN2
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Sep 2024 17:52:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725349929;
	cv=none; b=DVhd20DaQ0Y9q1Ils5JrddsV996bzKoeYJ+FEKHVaLgVWsaFahtevW4PpmF+A1A3aWSmHnhkDY3h0bQFpEE66rYDmFC58d4e5igQad68xP2aWJAmbI/wmQGombIDhsp9vfYlTacKaeZKNgqjPojUPEpbxeogwe1v70j9Z3P81x2TRzSerWOWgNrXIZIFL0I6CBOaNiwMCUQ97sBv1oDYjD3oSyok/H19Rqy/se/iFlb6YIKPpld2vO02wXNZZiER9ohaOkyjZPifRrjNaGkuIKPjVavDlglPvCogFYrkoCaVxXFb4NDJdseSar7fPbgeHJ8NrCGf1sN9r4nh7W6XKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725349929; c=relaxed/relaxed;
	bh=S08P1oPzvN4HiSvLQGbun7RQ9wwwnX81feCPigcCmus=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To:Content-Type; b=Hf/pdHNUIQiHzxjW0/oBoFx70TCaJNjExAii+il/kB2/ZGVy9zhnkPLUu5XHet3HKMsl4BBSeMuz9Z801AFcis06YvP1JgNvJ+iUpQNp3hutICJBoi2ReotjuSdyd3lJwTJM25xHBCk1VcjWpOQeXrlTaykfegW7aclsPcwgC+ZA0MbMX1C5QUFUvdJ0JnQJYFtK5ttcN6bjVb47woX9F7+mXhJuGLflcIEbUY5bOQEeWOrApLUcD64ti72OMyswYB9g11oEeaYOQbb3382u7EJuuE1cx0luTcwML0OYgLTxn2Ugx6hfbge7Jvg8e6jfFTB6dJwNEYn+LQ69Y7uIBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FV8maK1m; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FV8maK1m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WydBJ2cjpz2xdY
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Sep 2024 17:52:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725349922; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=S08P1oPzvN4HiSvLQGbun7RQ9wwwnX81feCPigcCmus=;
	b=FV8maK1mMEjjBg4rIXFUHHCFq25YB/uR9XoIXSok4McuYcCXXA3pMHdVsoyba1GSHDDmsh+Tn9KKKxFiniG5cFuNta1IfJWiM+Gp1Epl4/cXkBQtUCMIPKaA9l8rqHb+mJUN6jK9wCDRlWVuWkTQ8dMtA+3cznMwtIcR2no4ZQo=
Received: from 30.221.133.50(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WECXOKP_1725349912)
          by smtp.aliyun-inc.com;
          Tue, 03 Sep 2024 15:52:01 +0800
Message-ID: <3eed7e13-2c57-4105-a08e-fb2a72535f3d@linux.alibaba.com>
Date: Tue, 3 Sep 2024 15:51:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: fsck: add --xattr option
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240903073517.3311407-1-hongzhen@linux.alibaba.com>
 <81e992e3-a5af-439f-b4bf-f8c8861b1b62@linux.alibaba.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <81e992e3-a5af-439f-b4bf-f8c8861b1b62@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 2024/9/3 15:41, Gao Xiang wrote:
>
>
> On 2024/9/3 15:35, Hongzhen Luo wrote:
>> The current `fsck --extract` does not support exporting the extended
>> attributes of files. This patch adds `--xattr` option to dump the
>> extended attributes.
>
> only `--xattrs` is not helpful, you'd better to add both
> `--xattrs` and `--no-xattrs`, and makes `--xattrs` enabled
> by default.
>
Sure, I will do this in the next patch.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> ---
>>   fsck/main.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 61 insertions(+)
>>
>> diff --git a/fsck/main.c b/fsck/main.c
>> index 28f1e7e..6a71791 100644
>> --- a/fsck/main.c
>> +++ b/fsck/main.c
>> @@ -9,6 +9,7 @@
>>   #include <utime.h>
>>   #include <unistd.h>
>>   #include <sys/stat.h>
>> +#include <sys/xattr.h>
>>   #include "erofs/print.h"
>>   #include "erofs/compress.h"
>>   #include "erofs/decompress.h"
>> @@ -31,6 +32,7 @@ struct erofsfsck_cfg {
>>       bool overwrite;
>>       bool preserve_owner;
>>       bool preserve_perms;
>> +    bool xattr;
>
>     bool dump_xattrs;
>
>>   };
>>   static struct erofsfsck_cfg fsckcfg;
>>   @@ -48,6 +50,7 @@ static struct option long_options[] = {
>>       {"no-preserve-owner", no_argument, 0, 10},
>>       {"no-preserve-perms", no_argument, 0, 11},
>>       {"offset", required_argument, 0, 12},
>> +    {"xattr", no_argument, 0, 13},
>
> --xattrs, --no-xattrs
>
>>       {0, 0, 0, 0},
>>   };
>>   @@ -98,6 +101,7 @@ static void usage(int argc, char **argv)
>>           " --extract[=X]          check if all files are well 
>> encoded, optionally\n"
>>           "                        extract to X\n"
>>           " --offset=#             skip # bytes at the beginning of 
>> IMAGE\n"
>> +        " --xattr                dump extended attributes\n"
>>           "\n"
>>           " -a, -A, -y             no-op, for compatibility with fsck 
>> of other filesystems\n"
>>           "\n"
>> @@ -225,6 +229,9 @@ static int erofsfsck_parse_options_cfg(int argc, 
>> char **argv)
>>                   return -EINVAL;
>>               }
>>               break;
>> +        case 13:
>> +            fsckcfg.xattr = true;
>> +            break;
>>           default:
>>               return -EINVAL;
>>           }
>> @@ -411,6 +418,53 @@ out:
>>       return ret;
>>   }
>>   +static int erofs_dump_xattr(struct erofs_inode *inode)
>
> erofsfsck_dump_xattrs
>
>> +{
>> +    char *keylst, *key;
>> +    ssize_t kllen;
>> +    int ret;
>> +
>> +    if (!fsckcfg.extract_path)
>
> If extract_path is none, please keep reading the xattrs
> but don't dump these.
>> +        return 0;
>> +    kllen = erofs_listxattr(inode, NULL, 0);
>> +    if (kllen <= 0)
>> +        return kllen;
>> +    keylst = malloc(kllen);
>> +    if (!keylst)
>> +        return -ENOMEM;
>> +    ret = erofs_listxattr(inode, keylst, kllen);
>> +    if (ret < 0)
>> +        goto out;
>> +    for (key = keylst; key < keylst + kllen; key += strlen(key) + 1) {
>> +        void *value = NULL;
>> +        size_t size = 0;
>> +
>> +        ret = erofs_getxattr(inode, key, NULL, 0);
>> +        if (ret < 0)
>> +            goto out;
>
> why not just `break;` this?
My original intention was to think that `goto out;` and `break;` were 
equivalent here. But, yes, I will make changes in the next version.
>
>> +        if (ret) {
>> +            size = ret;
>> +            value = malloc(size);
>> +            if (!value) {
>> +                ret = -ENOMEM;
>> +                goto out;
>
> same here.
Ditto.
>
>> +            }
>> +            ret = erofs_getxattr(inode, key, value, size);
>> +            if (ret < 0) {
>> +                free(value);
>> +                goto out;
>
> same here.
>
>> +            }
>> +            ret = setxattr(fsckcfg.extract_path, key, value, size, 0);
>> +            free(value);
>> +            if (ret)
>> +                goto out;
>
> same here.
>
> Thanks,
> Gao Xiang
>
>> +        }
>> +    }
>> +out:
>> +    free(keylst);
>> +    return ret;
>> +}

---

Thanks,

Hongzhen Luo

