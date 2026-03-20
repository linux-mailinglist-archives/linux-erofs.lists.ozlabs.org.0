Return-Path: <linux-erofs+bounces-2868-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kABBM+KkvGk/1wIAu9opvQ
	(envelope-from <linux-erofs+bounces-2868-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 02:37:38 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DADEF2D4D27
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 02:37:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcQDG18Lcz2xm3;
	Fri, 20 Mar 2026 12:37:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773970654;
	cv=none; b=YjVRnVawke5UrU0Z9xN2ZRNCONMjvortRTY+lQ9uqtA8cjDIX8zVercMrnVrPfYEZPjmn5cWG9540gh+vl/s55HggQatnvCc7OESE0zejEuO9rFWGlbZk3zyDvPMasiOABYHoc8e835Tn3PghJgIoWEy52bb3BjkQ71Wycz2GlFBVrJBQ2BXEmkKwN4MMbqBrZBZ/UPpusufQGdgQlOY/D/iepIn7/YKutuh0ieZ/gKvenMNqjk6CnV4ymDK1UB9Hx5RBTMh+DtOyPuWGT4utAqvWethp+coYCeghAi9TBYmk1dpNtoiheeQmN09gdS+E7W+rz7twLYsS5DyArve1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773970654; c=relaxed/relaxed;
	bh=FVFrt7jv/SC6g1rr9zjJ8IpL06ZSy5Zu1F83NBLNHEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bz+iGYsHSQiIM9SZupSLbfSsJJa0AOdkCmW+cDEcbnkNz6N2r6zN9R35uuOVVdAssTX6tSKiArfh9CA1eWC4cXyw0rB6I43adMTVs0RbdsBkGVTcND45+4Lcvqt4mzlekKd4UGRbad4E1Iw44c4z2DSatPeUt1RvmOWpTBbR0PGyCUh1f+NbRzy7BN/f1HiashG+agFNtvN+TNsv1QQc7bHkK6gsjE/2gbQFAuw2oCIzLaRRlqB61EEzPdaJg2IwplGYigTfXwW4T8AY3FWb7YmaZycmZGGg9QQdVq9FS+Kw+1BjsrBYL/Sir0+6nuUD5XqEfdXMacPMB2iHii6pZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=u6DQBSTr; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=u6DQBSTr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcQDC5t6Cz2xly
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 12:37:29 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773970644; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=FVFrt7jv/SC6g1rr9zjJ8IpL06ZSy5Zu1F83NBLNHEE=;
	b=u6DQBSTr/umiOBYmuRD3hqwMH0c9+E04ajQEcEBIOoKkBWTpwxEQHakqj1i25eZFP2mzpChRxCb2AU4211bus1tXKuxLY5WG5p8zBp6EGpFA8Tlf6pCECyVAUZcZG/TmyAf39SonQzTuwsGyOekOMhbu90QLWxjbvx/PYiBxY7w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X.JxGgx_1773970641;
Received: from 30.221.131.211(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.JxGgx_1773970641 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Mar 2026 09:37:22 +0800
Message-ID: <0b0ad26c-f462-4274-aaad-6a8e079c0963@linux.alibaba.com>
Date: Fri, 20 Mar 2026 09:37:21 +0800
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
Subject: Re: [PATCH] erofs-utils: lib: fix QPL job leak on early error paths
 in z_erofs_decompress_qpl() After z_erofs_qpl_get_job() succeeds, two
 early-return error paths bypass z_erofs_qpl_put_job(), leaking the QPL job
 handle: - Line 200: return -EFSCORRUPTED (when inputmargin >= inputsize) -
 Line 205: return -ENOMEM (when malloc fails for decodedskip buffer) Fix by
 replacing the bare returns with goto out_inflate_end, which already handles
 both z_erofs_qpl_put_job() and free(buff).
To: Ajay Rajera <newajay.11r@gmail.com>, Vi-shub <smsharma3121@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, yifan@pku.edu.cn
References: <20260319221136.2126-1-smsharma3121@gmail.com>
 <CAMhhD9hbenqz2z2pRQ1EoSNttATsTnW9BZcgFVZ1VPCzAciHiw@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAMhhD9hbenqz2z2pRQ1EoSNttATsTnW9BZcgFVZ1VPCzAciHiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-4.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	LONG_SUBJ(3.00)[477];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2868-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:newajay.11r@gmail.com,m:smsharma3121@gmail.com,m:linux-erofs@lists.ozlabs.org,m:yifan@pku.edu.cn,m:newajay11r@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: DADEF2D4D27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/20 09:16, Ajay Rajera wrote:
> Hi Vi-shub,
> just a review :
> I think the fix looks correct and it is the right approach but the
> commit message formatting needs work. The entire description is in the
> subject line. Per kernel conventions, the subject should be a short
> one-liner, e.g: erofs-utils: lib: fix QPL job leak on early error
> paths
> The detailed explanation (which error paths leak, why, and how the fix
> works) should go in the commit message body, separated from the
> subject.
> 
> So you can resend with the subject/body split fixed? so It will look more clear.

yes, the commit message is in a mess.

Thanks,
Gao Xiang

> Thanks, Ajay


