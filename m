Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 405DE96E80A
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Sep 2024 05:13:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X0LsZ6ybtz3041
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Sep 2024 13:13:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725592416;
	cv=none; b=ZdQScdaTUmfsZENSh+kkGmywSm8OYOfTF8qCwflc/OMsChJdz5ca5N41mnCh92SY1Ruv3kF/2cvzvIQqGX016EVTlp9IjofMoEt89QkBJjkc9+bDb+A7jVpxdIkNk8PDENsds5a/CpsGEGjU2vaOr90IC0wdGmtFrC7FHea8ids33TzWnU7mNfgnCVeosyvNcwlEK/xf9H3vykXtUNjNapRTZgjTfL0YBfLjFCzJPrjJ0tI4JNVUKNcAmaKzolmeJz//gvX1zGdOegRsuB/J4QV2A143LDFDnUMEJBJYRdvVQjlm+EKThiw+TXcNgD1zDLZA3DWEW0vGEPW+H9UKXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725592416; c=relaxed/relaxed;
	bh=MkcsHJnApU3pTkgw5cMhgSF3LOjD8t/cXtU/dbqQVnU=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To:Content-Type; b=UaPd/Wdmi7vifId3xrI9mNU9TmE164QYT8dKeVlr7yYg5/8sjigEsYSodrJIU/+qh3SHW8ezY1ZO8J4gr8V8yadQfRNrYWKuKsMTasMUCvDhBDbG3EPBNr1m0IFm/vjE0R1p9LhiNkg8vYt1zsvfMUsuQTh7LNkEQcayiXeCofm9l9QqGTkJi45YV+L+q34Vu+mKs988E9H//sxP+KUWqd0f4jxW6H39rxdPSGC+dbSrbOhjbBF0J7xTbNaEdnGaPL5mFo+WA7P1a48EqKmWMYonyaOMOaktQgl7MNaK4TjPezK6BJFZM6oDnpR8+bGuCzs/SxXA+3vyGr22orqN5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nxeo/5wz; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nxeo/5wz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X0LsW6RMpz2yFD
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Sep 2024 13:13:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725592412; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MkcsHJnApU3pTkgw5cMhgSF3LOjD8t/cXtU/dbqQVnU=;
	b=nxeo/5wzz5QpFo5qFOSjKEMi0GdUOx/wdTAdY4hYQfQVYBsvXEZl/3CeXd7VoVAjn0eW+az3FRnp+vRnaEQUoScXCMBp+DOgxXnqHq0VQtQsTwyvF01nCinW28FeIqtR9fbab21fV/oKOLMHUamEpiyzUwrsDoo07JwaOuYG3pA=
Received: from 30.221.132.253(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WENlnXB_1725592410)
          by smtp.aliyun-inc.com;
          Fri, 06 Sep 2024 11:13:31 +0800
Message-ID: <223afda1-5829-41ab-80bb-6ee362dd5d0f@linux.alibaba.com>
Date: Fri, 6 Sep 2024 11:13:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External Mail]Re: [PATCH v5] erofs-utils: fsck: introduce
 exporting xattrs
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
 Huang Jianan <huangjianan@xiaomi.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
References: <20240906022206.2725584-1-hongzhen@linux.alibaba.com>
 <87c5bb2c-46b7-479f-9bd8-e555d472f105@linux.alibaba.com>
 <89bed599-5269-4b95-a6a2-6a3c9dff44ee@xiaomi.com>
 <85515042-6cd1-4748-b470-3388ab2296d4@linux.alibaba.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <85515042-6cd1-4748-b470-3388ab2296d4@linux.alibaba.com>
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


On 2024/9/6 11:09, Gao Xiang wrote:
> On 2024/9/6 10:46, Huang Jianan via Linux-erofs wrote:
>> On 2024/9/6 10:31, Gao Xiang wrote:
>>>
>>> Hi Jianan,
>>>
>>> On 2024/9/6 10:22, Hongzhen Luo wrote:
>>>> The current `fsck --extract` does not support exporting the extended
>>>> attributes of files. This patch adds `--xattrs` option to dump the
>>>> extended attributes, as well as the `--no-xattrs` option to not dump
>>>> the extended attributes.
>>>>
>>>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>>
>>> Could you confirm this version?
>>>
>>> Thanks,
>>> Gao Xiang
>>>
>>
>> LGTM.
>>
>> Reviewed-by: Jianan Huang <huangjianan@xiaomi.com>
>> Thanks,
>>
>>>> ---
>>>> v5: Adjust the help information.
>>>> v4: https://lore.kernel.org/all/20240905113723.1937634-1-
>>>> hongzhen@linux.alibaba.com/
>>>> v3: https://lore.kernel.org/all/20240903113729.3539578-1-
>>>> hongzhen@linux.alibaba.com/
>>>> v2: https://lore.kernel.org/all/20240903085643.3393012-1-
>>>> hongzhen@linux.alibaba.com/
>>>> v1: https://lore.kernel.org/all/20240903073517.3311407-1-
>>>> hongzhen@linux.alibaba.com/
>>>> ---
>>>>    fsck/main.c | 82 
>>>> ++++++++++++++++++++++++++++++++++++++++++++++++++---
>>>>    1 file changed, 78 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/fsck/main.c b/fsck/main.c
>>>> index 28f1e7e..d110cdb 100644
>>>> --- a/fsck/main.c
>>>> +++ b/fsck/main.c
>>>> @@ -9,6 +9,7 @@
>>>>    #include <utime.h>
>>>>    #include <unistd.h>
>>>>    #include <sys/stat.h>
>>>> +#include <sys/xattr.h>
>>>>    #include "erofs/print.h"
>>>>    #include "erofs/compress.h"
>>>>    #include "erofs/decompress.h"
>>>> @@ -31,6 +32,7 @@ struct erofsfsck_cfg {
>>>>        bool overwrite;
>>>>        bool preserve_owner;
>>>>        bool preserve_perms;
>>>> +     bool dump_xattrs;
>>>>    };
>>>>    static struct erofsfsck_cfg fsckcfg;
>>>>
>>>> @@ -48,6 +50,8 @@ static struct option long_options[] = {
>>>>        {"no-preserve-owner", no_argument, 0, 10},
>>>>        {"no-preserve-perms", no_argument, 0, 11},
>>>>        {"offset", required_argument, 0, 12},
>>>> +     {"xattrs", no_argument, 0, 13},
>>>> +     {"no-xattrs", no_argument, 0, 14},
>>>>        {0, 0, 0, 0},
>>>>    };
>>>>
>>>> @@ -98,6 +102,7 @@ static void usage(int argc, char **argv)
>>>>                " --extract[=X]          check if all files are well
>>>> encoded, optionally\n"
>>>>                "                        extract to X\n"
>>>>                " --offset=#             skip # bytes at the beginning
>>>> of IMAGE\n"
>>>> +             " --[no-]xattrs          whether to dump extended
>>>> attributes (default on)\n"
>>>>                "\n"
>>>>                " -a, -A, -y             no-op, for compatibility with
>>>> fsck of other filesystems\n"
>>>>                "\n"
>>>> @@ -225,6 +230,12 @@ static int erofsfsck_parse_options_cfg(int argc,
>>>> char **argv)
>>>>                                return -EINVAL;
>>>>                        }
>>>>                        break;
>>>> +             case 13:
>>>> +                     fsckcfg.dump_xattrs = true;
>>>> +                     break;
>>>> +             case 14:
>>>> +                     fsckcfg.dump_xattrs = false;
>>>> +                     break;
>>>>                default:
>>>>                        return -EINVAL;
>>>>                }
>>>> @@ -411,6 +422,60 @@ out:
>>>>        return ret;
>>>>    }
>>>>
>>>> +static int erofsfsck_dump_xattrs(struct erofs_inode *inode)
>>>> +{
>>>> +     char *keylst, *key;
>>>> +     ssize_t kllen;
>>>> +     int ret;
>>>> +
>>>> +     kllen = erofs_listxattr(inode, NULL, 0);
>>>> +     if (kllen <= 0)
>>>> +             return kllen;
>>>> +     keylst = malloc(kllen);
>>>> +     if (!keylst)
>>>> +             return -ENOMEM;
>>>> +     ret = erofs_listxattr(inode, keylst, kllen);
>>>> +     if (ret < 0)
>>>> +             goto out;
>>>> +     for (key = keylst; key < keylst + kllen; key += strlen(key) + 
>>>> 1) {
>>>> +             void *value = NULL;
>>>> +             size_t size = 0;
>>>> +
>>>> +             ret = erofs_getxattr(inode, key, NULL, 0);
>>>> +             if (ret < 0)
>>>> +                     break;
>>>> +             if (ret) {
>>>> +                     size = ret;
>>>> +                     value = malloc(size);
>>>> +                     if (!value) {
>>>> +                             ret = -ENOMEM;
>>>> +                             break;
>>>> +                     }
>>>> +                     ret = erofs_getxattr(inode, key, value, size);
>>>> +                     if (ret < 0) {
>>>> +                             erofs_err("fail to get xattr %s @ nid
>>>> %llu",
>>>> +                                       key, inode->nid | 0ULL);
>>>> +                             free(value);
>>>> +                             break;
>>>> +                     }
>>>> +                     if (fsckcfg.extract_path)
>>>> +                             ret = setxattr(fsckcfg.extract_path,
>>>> key, value,
>>>> +                                            size, 0);
>
> I still have some comments,
>
>  - need to update fsck manpages together;
>
>  - If `erofsfsck.superuser` is false, I guess we need to ignore
>    non-`user.` namespace xattrs.
>    If `erofsfsck.superuser` is true, we could dump all xattrs then.
>
>  - you should use lsetxattr instead of setxattr.
>
> Thanks,
> Gao Xiang
Sure, I will do these in the next patch.

Thanks,

Hongzhen

