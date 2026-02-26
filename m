Return-Path: <linux-erofs+bounces-2422-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNCUDwOyn2kpdQQAu9opvQ
	(envelope-from <linux-erofs+bounces-2422-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Feb 2026 03:37:55 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5DA1A026C
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Feb 2026 03:37:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLwby6Rgyz2ySS;
	Thu, 26 Feb 2026 13:37:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772073470;
	cv=none; b=HKjEQl7pdA7aINrYH6ti2wUggg+loI3+4CV8EyqXBw91EpjSeYcPE5rEYULHt9Qlw38jKOKotaFgiKFquiXsocAZh3QWCgqk1xp5X+ogKP56H70E9hQTcB1EV3wY6dVCI2V8yrO56+SQ9LSg3pE1oIG1rsYAufSeBXwixs1472fqpUyOZVt2RsRaXOSj44wRNkE1dKAaqqByaPC2REL5uNx7hh3TiJIGvI1/opLcqBbwsoWu4Ej4qm1ScJ9ZjUBDt22CLr1xtOC1AptQXmH1FLh1NPhSTquzN29ZYgigaDVOoZYHCnjRrPWBN+8DA+A6Dz6C3hvslFfCOGLJlPp1fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772073470; c=relaxed/relaxed;
	bh=C3W9GAMH/bBnYMtK3A4Mwh3VTYi0YYQrWpnvXSU9GIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDhS29KXDs51erwyIfsugfHjifbVB9nTfsnJk20rPyW9VvUD8rcQVyIxfvOGLzb5yzR0Sky2wcDziVDEeU4MlHd/GTaOvykr+O7EfV273/9lfB773Qh5ZG6uCBgYKG+fA/ugXafSrlpSb7GiOysB4G5LyvfOAoJvhEVCw365+znZeMstp/QJtDoeLQ85wyqIGjdBfBE7oN1BjILafG7tVzGo94sgAJ9+62ZMUavJlKtl4ZU3a1UhemwpuOkRkcT4jGTPBpHtwJlyTQ5MHxhyEcrCfNQWorSNpd5IZGI1Rl29IVL1VGcbk/9eaVUF2NM40z6Q8ZY0c9N2aYA/KsOgpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SPMAvv+i; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SPMAvv+i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLwbw6N4fz2xQs
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Feb 2026 13:37:47 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772073462; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=C3W9GAMH/bBnYMtK3A4Mwh3VTYi0YYQrWpnvXSU9GIY=;
	b=SPMAvv+i9Pztuqq4Rbx+jRkKLG3M/k8nkSK0L2Ff6YWU+kDYTnP53l2ErH1agYHGCiDKlJjvRalCgamMM1r1jnKj0SNilZ85n2Akd0/AiznDBKQer1V8YHDUDY+vVnOI9UA09SAoP8FypU7LFQmkcO2wOPqUEik5geJC06q1PTo=
Received: from 30.221.131.221(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WzpZtPQ_1772073461 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Feb 2026 10:37:41 +0800
Message-ID: <f93ceb56-9ddc-47c8-a3d5-c4ccc91f3a28@linux.alibaba.com>
Date: Thu, 26 Feb 2026 10:37:41 +0800
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
Subject: Re: [PATCH] erofs-utils: fsck: support extracting subtrees
To: Inseob Kim <inseob@google.com>
Cc: linux-erofs@lists.ozlabs.org
References: <20260226005913.3703242-1-inseob@google.com>
 <de02ce86-c2dd-491d-b418-087ddde5b31c@linux.alibaba.com>
 <CA+QFDKmznnFDVM7OBVWNQdTzXUu3o1vq0ALZjq54Nb530tpL6w@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CA+QFDKmznnFDVM7OBVWNQdTzXUu3o1vq0ALZjq54Nb530tpL6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-2422-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:inseob@google.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: 6E5DA1A026C
X-Rspamd-Action: no action



On 2026/2/26 10:18, Inseob Kim wrote:
> On Thu, Feb 26, 2026 at 10:50 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> Hi Inseob,
>>
>> On 2026/2/26 08:59, Inseob Kim wrote:
>>> Add --nid and --path options to fsck.erofs to allow users to check
>>> or extract specific sub-directories or files instead of the entire
>>> filesystem.
>>>
>>> This is useful for targeted data recovery or verifying specific
>>> image components without the overhead of a full traversal.
>>
>> Thanks for the patch!
> 
> Thank *you* for quick response!
> 
>>
>>>
>>> Signed-off-by: Inseob Kim <inseob@google.com>
>>> ---
>>>    fsck/main.c | 50 ++++++++++++++++++++++++++++++++++++++++----------
>>>    1 file changed, 40 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/fsck/main.c b/fsck/main.c
>>> index ab697be..a7d9f46 100644
>>> --- a/fsck/main.c
>>> +++ b/fsck/main.c
>>> @@ -39,6 +39,8 @@ struct erofsfsck_cfg {
>>>        bool preserve_owner;
>>>        bool preserve_perms;
>>>        bool dump_xattrs;
>>> +     erofs_nid_t nid;
>>> +     const char *inode_path;
>>>        bool nosbcrc;
>>>    };
>>>    static struct erofsfsck_cfg fsckcfg;
>>> @@ -59,6 +61,8 @@ static struct option long_options[] = {
>>>        {"offset", required_argument, 0, 12},
>>>        {"xattrs", no_argument, 0, 13},
>>>        {"no-xattrs", no_argument, 0, 14},
>>> +     {"nid", required_argument, 0, 15},
>>> +     {"path", required_argument, 0, 16},
>>>        {"no-sbcrc", no_argument, 0, 512},
>>>        {0, 0, 0, 0},
>>>    };
>>> @@ -110,6 +114,8 @@ static void usage(int argc, char **argv)
>>>                " --extract[=X]          check if all files are well encoded, optionally\n"
>>>                "                        extract to X\n"
>>>                " --offset=#             skip # bytes at the beginning of IMAGE\n"
>>> +             " --nid=#                check or extract from the target inode of nid #\n"
>>> +             " --path=X               check or extract from the target inode of path X\n"
>>>                " --no-sbcrc             bypass the superblock checksum verification\n"
>>>                " --[no-]xattrs          whether to dump extended attributes (default off)\n"
>>>                "\n"
>>> @@ -245,6 +251,12 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
>>>                case 14:
>>>                        fsckcfg.dump_xattrs = false;
>>>                        break;
>>> +             case 15:
>>> +                     fsckcfg.nid = (erofs_nid_t)atoll(optarg);
>>> +                     break;
>>> +             case 16:
>>> +                     fsckcfg.inode_path = optarg;
>>> +                     break;
>>>                case 512:
>>>                        fsckcfg.nosbcrc = true;
>>>                        break;
>>> @@ -981,7 +993,8 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
>>>
>>>        if (S_ISDIR(inode.i_mode)) {
>>>                struct erofs_dir_context ctx = {
>>> -                     .flags = EROFS_READDIR_VALID_PNID,
>>> +                     .flags = (pnid == nid && nid != g_sbi.root_nid) ?
>>
>> Does it relax the validatation check?
>>
>> and does (nid == pnid && nid == fsckcfg.nid) work?
> 
> It shouldn't relax the existing validation check.
> `erofsfsck_check_inode` is called with `err =
> erofsfsck_check_inode(fsckcfg.nid, fsckcfg.nid);`.
> 
> * If a given path is not the root, `nid`'s parent `..` will differ
> from `pnid`, causing failure. This condition only relaxes the starting
> directory.

I just have a wild thought, if there is a directory which have

  foo/
  | - .. -> pointing to `foo` itself
    - a/ -> pointing to `foo` directory too

will (pnid == nid && nid != g_sbi.root_nid) relaxs
the check for a/ ?

I'm not sure but you could double check.

> * In the case of the root, `nid`'s parent `..` should indeed be
> itself. So we can still validate.
> 
> If you have any better suggestions, I'll follow them.
> 
>>
>>> +                             0 : EROFS_READDIR_VALID_PNID,
>>>                        .pnid = pnid,
>>>                        .dir = &inode,
>>>                        .cb = erofsfsck_dirent_iter,
>>> @@ -1033,6 +1046,8 @@ int main(int argc, char *argv[])
>>>        fsckcfg.preserve_owner = fsckcfg.superuser;
>>>        fsckcfg.preserve_perms = fsckcfg.superuser;
>>>        fsckcfg.dump_xattrs = false;
>>> +     fsckcfg.nid = 0;
>>> +     fsckcfg.inode_path = NULL;
>>>
>>>        err = erofsfsck_parse_options_cfg(argc, argv);
>>>        if (err) {
>>> @@ -1068,22 +1083,37 @@ int main(int argc, char *argv[])
>>>        if (fsckcfg.extract_path)
>>>                erofsfsck_hardlink_init();
>>>
>>> -     if (erofs_sb_has_fragments(&g_sbi) && g_sbi.packed_nid > 0) {
>>> -             err = erofs_packedfile_init(&g_sbi, false);
>>> +     if (fsckcfg.inode_path) {
>>> +             struct erofs_inode inode = { .sbi = &g_sbi };
>>> +
>>> +             err = erofs_ilookup(fsckcfg.inode_path, &inode);
>>>                if (err) {
>>> -                     erofs_err("failed to initialize packedfile: %s",
>>> -                               erofs_strerror(err));
>>> +                     erofs_err("failed to lookup %s", fsckcfg.inode_path);
>>>                        goto exit_hardlink;
>>>                }
>>
>> It would be better to check if it's a directory.
> 
> My intention was that we support both directories and files. Or should
> I create a separate flag like `--cat` in dump.erofs?

Ok, make sense.

Thanks,
Gao Xiang

