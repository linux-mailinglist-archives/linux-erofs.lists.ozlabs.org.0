Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C1996E786
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Sep 2024 04:07:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X0KNg6WP1z303B
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Sep 2024 12:06:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725588415;
	cv=none; b=VzN/Ly+ImPff730RTW9fDAwUReuZhfgo1K1dXqh9enLXfkUcNKp3/9VuveYpm+jTdZLQmNem/sYpKrsRqm/xJbuGA2tQ8tEsLEwv0D2/1GIM3Y5dHcYzkxvOKd2Rl5X2u0Pmb8IkGCb1q5bC2QlVaVm98VyyAFDFXx/pckmPWBEjbdFb/KG9rYaZYWUQw+wKAntYy7mzeNXFBgwT1EZY3/CrYJ8KG0jxhpzph/9TCNsDZTDt8cQJb7hPJ50lM5HGC+vROK7CWrdi5JysypVIfVTgQlgDI23gZDOexzjO0C8rrZbcWlF1M9fSJC7WV7odIx/u2fHGAf2N6bORlaURbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725588415; c=relaxed/relaxed;
	bh=MzAdln90VpVNPRyqASk3GZ+r8xtA3XjMFG22JbPCvQ0=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To:Content-Type; b=MwDCB6GNuXiuw/5R4jEc+gmdSppgkFeQEnqoZxl065PJIwKnlFMtj78W592ILFqMm8sCYX6D0LatAnkEQomHlrnyJsOAwSTVHdcDYGkRws15McdRergzr6mTUCBGyHFg6R2U44FaEDKV7O1kW5ti1q++w7oq7S3gndB/sfKyYvILflaxrcqEoygnVCf0/H7oWPDZrk7x5RTDF4kb4DvQQXHuQU6jwzzzRyXtxZ9TpZLKJBxsNkAxo3QGReMrjLblyaaBynQQAOPfD2W40rWolOY7p0nwejJBMkOPlCwGSyVxwGxgEo88jA00d2XJX/W/CiJhh3WM4GdhkQtmWnRkNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=U6645onn; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=U6645onn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X0KNY6gN2z2y3b
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Sep 2024 12:06:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725588407; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MzAdln90VpVNPRyqASk3GZ+r8xtA3XjMFG22JbPCvQ0=;
	b=U6645onnSLmGQqLECIZENQW1MdBkEw0v9i4XCAP327BzgTHCClfITSNNvRDx2X2Zfo9+VYyp8sJ/WpSBE1RxHkA5HMCYvM5UFX0+e20ytod4a0l25lR6oDJVoN1E+hjZRANCY+zSpy7gSyluH+oyY5A3boIWoKHKF9OxubvcYnM=
Received: from 30.221.132.253(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WENXx3t_1725588395)
          by smtp.aliyun-inc.com;
          Fri, 06 Sep 2024 10:06:46 +0800
Message-ID: <1d763972-93f4-426a-9a8c-846d02813773@linux.alibaba.com>
Date: Fri, 6 Sep 2024 10:06:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External Mail][PATCH v4] erofs-utils: fsck: introduce exporting
 xattrs
To: Huang Jianan <huangjianan@xiaomi.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
References: <20240905113723.1937634-1-hongzhen@linux.alibaba.com>
 <b1932b1a-e30a-4665-a268-32b4b74d648c@xiaomi.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <b1932b1a-e30a-4665-a268-32b4b74d648c@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 2024/9/5 20:02, Huang Jianan wrote:
> On 2024/9/5 19:37, Hongzhen Luo wrote:
>> The current `fsck --extract` does not support exporting the extended
>> attributes of files. This patch adds `--xattrs` option to dump the
>> extended attributes, as well as the `--no-xattrs` option to not dump
>> the extended attributes.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> ---
>> v4: Optimize the error messages and code.
>> v3: https://lore.kernel.org/all/20240903113729.3539578-1-hongzhen@linux.alibaba.com/
>> v2: https://lore.kernel.org/all/20240903085643.3393012-1-hongzhen@linux.alibaba.com/
>> v1: https://lore.kernel.org/all/20240903073517.3311407-1-hongzhen@linux.alibaba.com/
>> ---
>>    fsck/main.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++---
>>    1 file changed, 79 insertions(+), 4 deletions(-)
>>
>> diff --git a/fsck/main.c b/fsck/main.c
>> index 28f1e7e..183665c 100644
>> --- a/fsck/main.c
>> +++ b/fsck/main.c
>> @@ -9,6 +9,7 @@
>>    #include <utime.h>
>>    #include <unistd.h>
>>    #include <sys/stat.h>
>> +#include <sys/xattr.h>
>>    #include "erofs/print.h"
>>    #include "erofs/compress.h"
>>    #include "erofs/decompress.h"
>> @@ -31,6 +32,7 @@ struct erofsfsck_cfg {
>>           bool overwrite;
>>           bool preserve_owner;
>>           bool preserve_perms;
>> +       bool dump_xattrs;
>>    };
>>    static struct erofsfsck_cfg fsckcfg;
>>
>> @@ -48,6 +50,8 @@ static struct option long_options[] = {
>>           {"no-preserve-owner", no_argument, 0, 10},
>>           {"no-preserve-perms", no_argument, 0, 11},
>>           {"offset", required_argument, 0, 12},
>> +       {"xattrs", no_argument, 0, 13},
>> +       {"no-xattrs", no_argument, 0, 14},
>>           {0, 0, 0, 0},
>>    };
>>
>> @@ -98,6 +102,8 @@ static void usage(int argc, char **argv)
>>                   " --extract[=X]          check if all files are well encoded, optionally\n"
>>                   "                        extract to X\n"
>>                   " --offset=#             skip # bytes at the beginning of IMAGE\n"
>> +               " --xattrs               dump extended attributes (default)\n"
>> +               " --no-xattrs            do not dump extended attributes\n"
> How about:
>
> " --[no-]xattrs  whether to dump extended attributes (default on)\n"
>
> To keep the same style as the other switch options.
>
> Thanks,
> Jianan

Yes, that would be more concise. I'll send a new version soon.

Thanks,

Hongzhen

>>                   "\n"
>>                   " -a, -A, -y             no-op, for compatibility with fsck of other filesystems\n"
>>                   "\n"
>> @@ -225,6 +231,12 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
>>                                   return -EINVAL;
>>                           }
>>                           break;
>> +               case 13:
>> +                       fsckcfg.dump_xattrs = true;
>> +                       break;
>> +               case 14:
>> +                       fsckcfg.dump_xattrs = false;
>> +                       break;
>>                   default:
>>                           return -EINVAL;
>>                   }
>> @@ -411,6 +423,60 @@ out:
>>           return ret;
>>    }
>>
>> +static int erofsfsck_dump_xattrs(struct erofs_inode *inode)
>> +{
>> +       char *keylst, *key;
>> +       ssize_t kllen;
>> +       int ret;
>> +
>> +       kllen = erofs_listxattr(inode, NULL, 0);
>> +       if (kllen <= 0)
>> +               return kllen;
>> +       keylst = malloc(kllen);
>> +       if (!keylst)
>> +               return -ENOMEM;
>> +       ret = erofs_listxattr(inode, keylst, kllen);
>> +       if (ret < 0)
>> +               goto out;
>> +       for (key = keylst; key < keylst + kllen; key += strlen(key) + 1) {
>> +               void *value = NULL;
>> +               size_t size = 0;
>> +
>> +               ret = erofs_getxattr(inode, key, NULL, 0);
>> +               if (ret < 0)
>> +                       break;
>> +               if (ret) {
>> +                       size = ret;
>> +                       value = malloc(size);
>> +                       if (!value) {
>> +                               ret = -ENOMEM;
>> +                               break;
>> +                       }
>> +                       ret = erofs_getxattr(inode, key, value, size);
>> +                       if (ret < 0) {
>> +                               erofs_err("fail to get xattr %s @ nid %llu",
>> +                                         key, inode->nid | 0ULL);
>> +                               free(value);
>> +                               break;
>> +                       }
>> +                       if (fsckcfg.extract_path)
>> +                               ret = setxattr(fsckcfg.extract_path, key, value,
>> +                                              size, 0);
>> +                       else
>> +                               ret = 0;
>> +                       free(value);
>> +                       if (ret) {
>> +                               erofs_err("fail to set xattr %s @ nid %llu",
>> +                                         key, inode->nid | 0ULL);
>> +                               break;
>> +                       }
>> +               }
>> +       }
>> +out:
>> +       free(keylst);
>> +       return ret;
>> +}
>> +
>>    static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
>>    {
>>           struct erofs_map_blocks map = {
>> @@ -900,15 +966,23 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
>>                   goto out;
>>           }
>>
>> -       /* verify xattr field */
>> -       ret = erofs_verify_xattr(&inode);
>> -       if (ret)
>> -               goto out;
>> +       if (!fsckcfg.check_decomp) {
>> +               /* verify xattr field */
>> +               ret = erofs_verify_xattr(&inode);
>> +               if (ret)
>> +                       goto out;
>> +       }
>>
>>           ret = erofsfsck_extract_inode(&inode);
>>           if (ret && ret != -ECANCELED)
>>                   goto out;
>>
>> +       if (fsckcfg.check_decomp && fsckcfg.dump_xattrs) {
>> +               ret = erofsfsck_dump_xattrs(&inode);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>>           /* XXXX: the dir depth should be restricted in order to avoid loops */
>>           if (S_ISDIR(inode.i_mode)) {
>>                   struct erofs_dir_context ctx = {
>> @@ -955,6 +1029,7 @@ int main(int argc, char *argv[])
>>           fsckcfg.overwrite = false;
>>           fsckcfg.preserve_owner = fsckcfg.superuser;
>>           fsckcfg.preserve_perms = fsckcfg.superuser;
>> +       fsckcfg.dump_xattrs = true;
>>
>>           err = erofsfsck_parse_options_cfg(argc, argv);
>>           if (err) {
>> --
>> 2.43.5
>>
