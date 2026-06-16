Return-Path: <linux-erofs+bounces-3629-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nl37KXc1MWoheAUAu9opvQ
	(envelope-from <linux-erofs+bounces-3629-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 13:37:27 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BACB168ED50
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 13:37:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UveqqbVn;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3629-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3629-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gflMl2LtKz3brH;
	Tue, 16 Jun 2026 21:37:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781609843;
	cv=none; b=FOfnRrJBXN9COGOJq9wT0uqTe744wz/b8+XKEPTjsD6MH6ga0nsT/RSrvAlATvg6LPrVO4Xe2sx3Ztabhg+z7Vii0b9lAOP65IvQ0/YeVsILQ4/bGUX94dp86Ndaw1I4vRYyPemq362VPSz3uQccLpxKlr+32HLIom0rZ/2lGjPZhr9BCtI36zbqMABxpD6yNdy3RBWkT2uT/aZTYWdT86FGH7ew3+Hb4bzez+Uc1ZqDBEQjdz2virP3wpkGqVDBA60VMKTlLMCEloiTev3/BW6FLwePCA/8FP4oDQbT+qiQC0RbBEhDLDkIrVdeMGeNFBpI5Es7BzxFZfeHI795pw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781609843; c=relaxed/relaxed;
	bh=u71kaFwvfS1PR3bDQek8C2zDFTdze02lLLx2QJNNW8k=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SBTrC2B1jELuHblMCR2T0N9nyStVMyICyb6f3DcQbLgSI8NSpH6QLz6YGHFBSqtsuzz7dO/gmatjllqLsrPljdtjoNpO8FsA8YGxBR34qf4WdH13TKsG8OEUt8jR1dsynBTlfuWNwKBaynAHWIOnQEpwhQKEf9UCetBIyo09XW8LpE3RBKn2p4Cw4WvbLlhieVQZYv4jrt4/nf5aEl8arxayuc8zzbPGlRW9eR8DvdBy1KsEOLhveptIYYR0X8uvfnA26A5VabSBxX7MBIb3EW0GaKv+DqbIrTa00LorE9b0hfZsOoqn4nxjP7AmXn8sn+1HewuuJj6XpkyxqXJpaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UveqqbVn; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gflMk4DdVz3bqh
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jun 2026 21:37:22 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 49680434FB;
	Tue, 16 Jun 2026 11:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DD41F000E9;
	Tue, 16 Jun 2026 11:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781609840;
	bh=u71kaFwvfS1PR3bDQek8C2zDFTdze02lLLx2QJNNW8k=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=UveqqbVnPvAmN3Rjxt5vG/08opAQAyIypfBxteU38dBOUZN3POOuZQL73e7ft1+el
	 9urLhRs5Wfa1e3RrIne7EcfLPLXkdr9xKAnJSQCcLUZkLnxloxMjEOzLHd4bHui/Gg
	 qulNasDYrgeMmacW8ygG7+mpOf6TADlw/Rwgc1b7osIChe17mLkGyQLZqzXgijdeEz
	 k71r7G9nYEEVt/UPUCwzcHc2bmsTw1Gx6s4cyp27VSP+tC761nQwibE7Xui7D5X3q3
	 8apM4eYnZKEbV1Tmb4HDJU1EqRnEzhp7EzeVegrVkq44zGJMS7mj+eybpi6Tu+xQcL
	 LL7H0wsYgCfuw==
Message-ID: <cf679da5-fbd0-41c6-b5ae-e6a677b98cfd@kernel.org>
Date: Tue, 16 Jun 2026 11:37:17 +0000
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
Cc: chao@kernel.org, oliver.yang@linux.alibaba.com,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] erofs: update the overview of the documentation
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20260610030532.3170375-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260610030532.3170375-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:oliver.yang@linux.alibaba.com,m:linux-kernel@vger.kernel.org,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-3629-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BACB168ED50

On 6/10/26 03:05, Gao Xiang wrote:
> Update the overview section to better reflect EROFS's design philosophy
> as an immutable image filesystem, update the feature highlights with
> recent capabilities, and remove outdated items.
> 
> The following detailed sections will be revised later since the overview
> section is the most visible part of our documentation. Outdated or
> ambiguous information could mislead new users and potential adopters.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

