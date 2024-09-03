Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC88969B3F
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Sep 2024 13:10:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WyjbV3pM0z2yN1
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Sep 2024 21:10:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725361843;
	cv=none; b=oeb5DOhRh3KlJ3es//QNN7ucy5toHooZqjzbWYfaGLUniWN2+60MFXe0ipJVIDnlTGld7SJoN5mqy/38LiH5umt6ohH3z+9Q9XrwZp4UBvnLZV2vfE8OJp2IvnWPncX3HgpC5/0QlM0RS7kuxIM386Dem5m0d6SblOhai7XbMHZqIZhvqxOf2wAe4gNxWDHrj+8Ietpwn7hQ1yldgl4hlArBbOJWoBMGLwSrx28aUR50lB4Sf7rQcOvgTbOBh3SJCSt9JVpnQNgTD1X0+/OYFJI/m0AJdxyX+Adv7uTMovVPieA6Gp6mbykiogPkMxSc64O6ZV9L4MnAt6wmoog25A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725361843; c=relaxed/relaxed;
	bh=wVQ1NLJ9GJz18hpBP2aDeaLg+xtXMgOh+Gennf3nEKM=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To:Content-Type; b=HNzOKqr5oO3ZOlXjmRdL4lG99pFdtMqyKf6HtclOWZWclAjNMfewU/Txlz55VKx9Y6spWmwUMiH2/ddQHW9IehuGqTmTBMnJ4STi547xx7EULm7JZGMIEpT69/B9CvVgqLZVexosyX/T9urNZmgcDUWVri/p89jtU694L3YyzFGxfSoNR2XBUlSlonOwuLkNXhwzBAFMQMfTdotW757pa3PQMwNT5btDDjxVdfGXMbDzZmkpYsuuVtF1l10akFw/OoDm4moAniAOH2wjO6xuldt7IQdQaKN28osjf0aEP1sYpIwRNfEA0cKNkWhvwC7QQ672PJx9pczvkwEex2IWLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Z5nmZHiM; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Z5nmZHiM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WyjbQ2ZVkz2xdg
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Sep 2024 21:10:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725361835; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wVQ1NLJ9GJz18hpBP2aDeaLg+xtXMgOh+Gennf3nEKM=;
	b=Z5nmZHiMEmE2fO4s0IY+rJbx8MomiAjmy7s7cRFxVfA0uSkSbwAeiBvz5o9qZrMtR5/vX/sjwypfV4XT4xVbJzJrReKWKwBnYif+CUG88JVBSbWBKM5xd3Azm6x5rqLOsK5SGk+g3R6T8oVK4LAZEzR8eHre+VFUafuDQXq7OWA=
Received: from 30.221.133.50(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WED6O0x_1725361833)
          by smtp.aliyun-inc.com;
          Tue, 03 Sep 2024 19:10:34 +0800
Message-ID: <5f6aa0ba-33e7-4cec-905b-8d4a6aceea12@linux.alibaba.com>
Date: Tue, 3 Sep 2024 19:10:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs-utils: fsck: add --xattrs and --no-xattrs
 options
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240903085643.3393012-1-hongzhen@linux.alibaba.com>
 <5469d0bc-3894-4e9d-a94d-75e184d3628d@linux.alibaba.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <5469d0bc-3894-4e9d-a94d-75e184d3628d@linux.alibaba.com>
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


On 2024/9/3 17:32, Gao Xiang wrote:
>
>
> On 2024/9/3 16:56, Hongzhen Luo wrote:
>> The current `fsck --extract` does not support exporting the extended
>> attributes of files. This patch adds `--xattrs` option to dump the
>> extended attributes, as well as the `--no-xattrs` option to not dump
>> the extended attributes.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> ---
>> v2: In addition to "--xattrs", the option "--no-xattrs" has been added.
>> v1: 
>> https://lore.kernel.org/all/20240903073517.3311407-1-hongzhen@linux.alibaba.com/
>> ---
>>   fsck/main.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 74 insertions(+)
>>
>> diff --git a/fsck/main.c b/fsck/main.c
>> index 28f1e7e..273bf73 100644
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
>> +    bool dump_xattrs;
>>   };
>>   static struct erofsfsck_cfg fsckcfg;
>>   @@ -48,6 +50,8 @@ static struct option long_options[] = {
>>       {"no-preserve-owner", no_argument, 0, 10},
>>       {"no-preserve-perms", no_argument, 0, 11},
>>       {"offset", required_argument, 0, 12},
>> +    {"xattrs", no_argument, 0, 13},
>> +    {"no-xattrs", no_argument, 0, 14},
>>       {0, 0, 0, 0},
>>   };
>>   @@ -98,6 +102,8 @@ static void usage(int argc, char **argv)
>>           " --extract[=X]          check if all files are well 
>> encoded, optionally\n"
>>           "                        extract to X\n"
>>           " --offset=#             skip # bytes at the beginning of 
>> IMAGE\n"
>> +        " --xattrs               dump extended attributes (default)\n"
>> +        " --no-xattrs            do not dump extended attributes\n"
>>           "\n"
>>           " -a, -A, -y             no-op, for compatibility with fsck 
>> of other filesystems\n"
>>           "\n"
>> @@ -225,6 +231,16 @@ static int erofsfsck_parse_options_cfg(int argc, 
>> char **argv)
>>                   return -EINVAL;
>>               }
>>               break;
>> +        case 13:
>> +            if (!fsckcfg.dump_xattrs) {
>> +                erofs_err("--xattrs conflicts with --no-xattrs");
>> +                return -EINVAL;
>> +            }
>
> No need this, the latter option will override the previous ones.
>
>> +            fsckcfg.dump_xattrs = true;
>> +            break;
>> +        case 14:
>> +            fsckcfg.dump_xattrs = false;
>> +            break;
>>           default:
>>               return -EINVAL;
>>           }
>> @@ -411,6 +427,57 @@ out:
>>       return ret;
>>   }
>>   +static int erofsfsck_dump_xattrs(struct erofs_inode *inode)
>> +{
>> +    char *keylst, *key;
>> +    ssize_t kllen;
>> +    int ret;
>> +
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
>> +            break;
>> +        if (ret) {
>> +            size = ret;
>> +            value = malloc(size);
>> +            if (!value) {
>> +                ret = -ENOMEM;
>
> I think error message is needed here.
>
>> +                break;
>> +            }
>> +            ret = erofs_getxattr(inode, key, value, size);
>> +            if (ret < 0) {
>
> Same here.
>
>> +                free(value);
>> +                break;
>> +            }
>> +            if (fsckcfg.extract_path) {
>> +                ret = setxattr(fsckcfg.extract_path, key, value,
>> +                           size, 0);
>> +                if (ret) {
>> +                    free(value);
>
> It seems that is unneeded.
>
>> +                    break;
>> +                }
>> +            } else
>> +                ret = 0;
>
> why not just
>             if (ret) {
>                 erofs_err(...);
>                 break;
>             }
>
> here?
>
Thanks for pointing this out. I will make the changes in the next version.

Thanks,

Hongzhen

>
>> +            free(value);
>> +        }
>> +    }
>> +out:
>> +    free(keylst);
>> +    return ret;
>> +}
>> +
>>   static int erofs_verify_inode_data(struct erofs_inode *inode, int 
>> outfd)
>>   {
>>       struct erofs_map_blocks map = {
>> @@ -909,6 +976,12 @@ static int erofsfsck_check_inode(erofs_nid_t 
>> pnid, erofs_nid_t nid)
>>       if (ret && ret != -ECANCELED)
>>           goto out;
>>   +    if (fsckcfg.dump_xattrs) {
>> +        ret = erofsfsck_dump_xattrs(&inode);
>> +        if (ret)
>> +            return ret;
>> +    }
>> +
>>       /* XXXX: the dir depth should be restricted in order to avoid 
>> loops */
>>       if (S_ISDIR(inode.i_mode)) {
>>           struct erofs_dir_context ctx = {
>> @@ -955,6 +1028,7 @@ int main(int argc, char *argv[])
>>       fsckcfg.overwrite = false;
>>       fsckcfg.preserve_owner = fsckcfg.superuser;
>>       fsckcfg.preserve_perms = fsckcfg.superuser;
>> +    fsckcfg.dump_xattrs= true;
>
> Missing space.
>
> Thanks,
> Gao Xiang
>
>>         err = erofsfsck_parse_options_cfg(argc, argv);
>>       if (err) {
