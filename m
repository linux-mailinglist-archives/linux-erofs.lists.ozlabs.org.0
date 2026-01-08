Return-Path: <linux-erofs+bounces-1704-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D6397D00ADB
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 03:32:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dmppp1smVz2yG3;
	Thu, 08 Jan 2026 13:32:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767839570;
	cv=none; b=N+lQu3RtPtbb2lLQfQFLQY98bNWqqY6wTULZjBltTdr73va5/vVCzzLvaqzSh4dEXkMVd14bQYyUEIg5jFvqGKdEcOoXCinkYY1AMFmX5D5LytPLli2s3I40RPGmYu8+/y+wo32szBkl1Wj+h6iYYMB+5Z1+FfjcmXv8kdMiuh6nFO3j3fFI5xjp0VsKIv75Sx46awUfh/7UjH1M4n0OkcM2LdcWfGFlfEOKGtHUhdgLHdhfozEtsqJzp25K5z1LEZhCVftWbkeE778XxV07uHwgf+DQgBMcNK+VIV91AAqCeecVh7M3SSdz60Go2PqRpS9bKU9CvOh2TKF6IB65uw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767839570; c=relaxed/relaxed;
	bh=TnDlvyf1ErszywFeRLERs8TqVYyXA0RnaEIQxb/B5WU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CrgHu5kh6S4/gR9YGSZyZ6D7y+GJD2FyYGyESz2f+7fKSYJItZkIqmYRNHW72l42lWPp8H+lh4isnF5RqOt7C7cOOnLkhMz7trZNel93iHYskfBtMKna92CpGUdHqWiOFg5rRN/81Z+9iPDnzSGyeHrk4gM1J13y7IxzJQzu0Gnls3uvuBP/x2/Aqiq1PN8DCGtflxGwG8sGEOfgYMGAxdKxVlAv7+HIEMPIbslphiXo6pBtyweB/abn10+cZ7LC+1FMutaGQ4oNpEYqr62bk8cgjBAaWAfYntSb7pNXy+U2TeJo6yORg791VWQoQPmlCoAgOAArVGQupY6NNllaCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hlKFtXYT; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hlKFtXYT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dmppl5jFzz2yFq
	for <linux-erofs@lists.ozlabs.org>; Thu, 08 Jan 2026 13:32:46 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767839561; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=TnDlvyf1ErszywFeRLERs8TqVYyXA0RnaEIQxb/B5WU=;
	b=hlKFtXYTSriSHnurOVgTfY+fZZMzSmIUGME361YfPCWMtWNl6HueeHpJ21k95p/VlC9nh7W5oLiVyebuamRHlqG7BZOYEWj7l4+dFjkFFs2ofEFMZ26sqgIPxYXQfcSOLFuCbe9+Hrf9zukcRgt7uwcpFN1O1ovSZ+ohNAWJrcM=
Received: from 30.221.132.104(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wwas.tE_1767839559 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Jan 2026 10:32:40 +0800
Message-ID: <41b8a0bb-96d3-4eba-a5b8-77b0b0ed4730@linux.alibaba.com>
Date: Thu, 8 Jan 2026 10:32:37 +0800
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
Subject: Re: [PATCH v2] erofs: don't bother with s_stack_depth increasing for
 now
To: Sheng Yong <shengyong2021@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Dusty Mabe <dusty@dustymabe.com>, =?UTF-8?Q?Timoth=C3=A9e_Ravier?=
 <tim@siosm.fr>, =?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>,
 Amir Goldstein <amir73il@gmail.com>, Alexander Larsson <alexl@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Miklos Szeredi
 <mszeredi@redhat.com>, Zhiguo Niu <niuzhiguo84@gmail.com>,
 shengyong1@xiaomi.com
References: <0c34f3fa-c573-4343-b8ea-6832530f0069@linux.alibaba.com>
 <20260106170504.674070-1-hsiangkao@linux.alibaba.com>
 <3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Sheng,

On 2026/1/8 10:26, Sheng Yong wrote:
> On 1/7/26 01:05, Gao Xiang wrote:
>> Previously, commit d53cd891f0e4 ("erofs: limit the level of fs stacking
>> for file-backed mounts") bumped `s_stack_depth` by one to avoid kernel
>> stack overflow when stacking an unlimited number of EROFS on top of
>> each other.
>>
>> This fix breaks composefs mounts, which need EROFS+ovl^2 sometimes
>> (and such setups are already used in production for quite a long time).
>>
>> One way to fix this regression is to bump FILESYSTEM_MAX_STACK_DEPTH
>> from 2 to 3, but proving that this is safe in general is a high bar.
>>
>> After a long discussion on GitHub issues [1] about possible solutions,
>> one conclusion is that there is no need to support nesting file-backed
>> EROFS mounts on stacked filesystems, because there is always the option
>> to use loopback devices as a fallback.
>>
>> As a quick fix for the composefs regression for this cycle, instead of
>> bumping `s_stack_depth` for file backed EROFS mounts, we disallow
>> nesting file-backed EROFS over EROFS and over filesystems with
>> `s_stack_depth` > 0.
>>
>> This works for all known file-backed mount use cases (composefs,
>> containerd, and Android APEX for some Android vendors), and the fix is
>> self-contained.
>>
>> Essentially, we are allowing one extra unaccounted fs stacking level of
>> EROFS below stacking filesystems, but EROFS can only be used in the read
>> path (i.e. overlayfs lower layers), which typically has much lower stack
>> usage than the write path.
>>
>> We can consider increasing FILESYSTEM_MAX_STACK_DEPTH later, after more
>> stack usage analysis or using alternative approaches, such as splitting
>> the `s_stack_depth` limitation according to different combinations of
>> stacking.
>>
>> Fixes: d53cd891f0e4 ("erofs: limit the level of fs stacking for file-backed mounts")
>> Reported-by: Dusty Mabe <dusty@dustymabe.com>
>> Reported-by: Timothée Ravier <tim@siosm.fr>
>> Closes: https://github.com/coreos/fedora-coreos-tracker/issues/2087 [1]
>> Reported-by: "Alekséi Naidénov" <an@digitaltide.io>
>> Closes: https://lore.kernel.org/r/CAFHtUiYv4+=+JP_-JjARWjo6OwcvBj1wtYN=z0QXwCpec9sXtg@mail.gmail.com
>> Acked-by: Amir Goldstein <amir73il@gmail.com>
>> Cc: Alexander Larsson <alexl@redhat.com>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: Miklos Szeredi <mszeredi@redhat.com>
>> Cc: Sheng Yong <shengyong1@xiaomi.com>
>> Cc: Zhiguo Niu <niuzhiguo84@gmail.com>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>> v2:
>>   - Update commit message (suggested by Amir in 1-on-1 talk);
>>   - Add proper `Reported-by:`.
>>
>>   fs/erofs/super.c | 18 ++++++++++++------
>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 937a215f626c..0cf41ed7ced8 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -644,14 +644,20 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>>            * fs contexts (including its own) due to self-controlled RO
>>            * accesses/contexts and no side-effect changes that need to
>>            * context save & restore so it can reuse the current thread
>> -         * context.  However, it still needs to bump `s_stack_depth` to
>> -         * avoid kernel stack overflow from nested filesystems.
>> +         * context.
>> +         * However, we still need to prevent kernel stack overflow due
>> +         * to filesystem nesting: just ensure that s_stack_depth is 0
>> +         * to disallow mounting EROFS on stacked filesystems.
>> +         * Note: s_stack_depth is not incremented here for now, since
>> +         * EROFS is the only fs supporting file-backed mounts for now.
>> +         * It MUST change if another fs plans to support them, which
>> +         * may also require adjusting FILESYSTEM_MAX_STACK_DEPTH.
>>            */
>>           if (erofs_is_fileio_mode(sbi)) {
>> -            sb->s_stack_depth =
>> -                file_inode(sbi->dif0.file)->i_sb->s_stack_depth + 1;
>> -            if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
>> -                erofs_err(sb, "maximum fs stacking depth exceeded");
>> +            inode = file_inode(sbi->dif0.file);
>> +            if (inode->i_sb->s_op == &erofs_sops ||
> 
> Hi, Xiang
> 
> In Android APEX scenario, apex images formatted as EROFS are packed in
> system.img which is also EROFS format. As a result, it will always fail
> to do APEX-file-backed mount since `inode->i_sb->s_op == &erofs_sops'
> is true.
> Any thoughts to handle such scenario?

Sorry, I forgot this popular case, I think it can be simply resolved
by the following diff:

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 0cf41ed7ced8..e93264034b5d 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -655,7 +655,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
                  */
                 if (erofs_is_fileio_mode(sbi)) {
                         inode = file_inode(sbi->dif0.file);
-                       if (inode->i_sb->s_op == &erofs_sops ||
+                       if ((inode->i_sb->s_op == &erofs_sops && !sb->s_bdev) ||
                             inode->i_sb->s_stack_depth) {
                                 erofs_err(sb, "file-backed mounts cannot be applied to stacked fses");
                                 return -ENOTBLK;

"!sb->s_bdev" covers file-backed EROFS mounts and
(deprecated) fscache EROFS mounts, I will send v3 soon.

Thanks,
Gao Xiang

> 
> thanks,
> shengyong
> 
>> +                inode->i_sb->s_stack_depth) {
>> +                erofs_err(sb, "file-backed mounts cannot be applied to stacked fses");
>>                   return -ENOTBLK;
>>               }
>>           }


