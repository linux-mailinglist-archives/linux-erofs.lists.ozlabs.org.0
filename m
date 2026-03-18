Return-Path: <linux-erofs+bounces-2824-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAovD1lBumnMTQIAu9opvQ
	(envelope-from <linux-erofs+bounces-2824-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 07:08:25 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476182B6349
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 07:08:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbJKc35d4z2xYk;
	Wed, 18 Mar 2026 17:08:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773814100;
	cv=none; b=RTzb7ZXXQrwoxYMAbM97KCoyShdw3caEGJSDe1OgGXJl3c70OgQTSi8cCyGf0ehutvtxNtee+lRe5Tqk076frHwDMAiRB/F8kVAIcRC7/5NTTkO9Kcts8ed/RO068+r4SJE+b1TVyFD1TTsFvhfJdVTiKtFSyyAWTDdSkoWmsuBe02pF6XLKE5kBkzyO2SD/2AcIWykXVtqk/E5WVOLfnlii4hFB9tHpFqJZy/s1tcYuM82+DjZakxIZHsYCXFnnNDTP7wnR7DFnP1JFSUK+4I9ZyAyhSAiPTUq9ZP/E1jCQyk+edWie+IisOYPKyLedQEvYZKMoSXlly+LoasM+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773814100; c=relaxed/relaxed;
	bh=81iU4GxYFjYy2wsoXiDzJqAgWFbrdp72/QRnLAtntXg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Kj/LUsIXDtbRHk3el6XuGLFv+p/ej3blW8CzpAYG8HxRwiAPII0/bWJG/Sf6T2IZ4ASBLC9gkRxcHNlRkASTP2kKb86KAmvk9l+rpIa2jrcIaxPMyQ5nk4dGG37V2LZdwAtCEglD+BYdj1DbXC2yYz3xXMwJEPS68twilRIiGiNg24wyRztIH0mg8DsVGmUa1JXkfBN+OhNVzpEBRF1pK1xxl8VZ5y/51VfDHc1h63ulrXSNxxOoeVQX+eZEpPA99O8DkMwhWek29unlvaPTk+/D86AVt3KU6cDl6aZ6iHIpPuncQ96RCdTMEnTv4bOoBViG2WhaFtVxZMBHx9v1kQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uN8CxQJB; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uN8CxQJB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbJKb64HGz2xQB
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 17:08:19 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E8370600C4;
	Wed, 18 Mar 2026 06:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B2DC19421;
	Wed, 18 Mar 2026 06:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773814097;
	bh=QVqJ+ZgjVb432Bp9YL91Pp7BrnCufp1ZeUvDfJS+iGU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=uN8CxQJB+z5DZbnUnA9JFDRYekiNfdTIKRHs4FYRQPk3mQMHqZ1IEyoJXP6nSwm54
	 oMcidtvta3iueIIkDanUgLI0qEtuAb1LoiPie3dwjW7EGs2TQ9RI8xPltLnqqevl5z
	 pMMda8gM4t0TrIEphvKrsKHFS9m3hv011bNtze7eLyjtBPDjH0xWuHVsk566o/7goX
	 aYOd492JQIjugq3KrjYWy2h5UpRoMySa6EcHRhLOdW/TVFN3RL/koV8TQLq4fSxt26
	 AH/P5lwHiNibC83POoeKinZTsk1PCKDJqJWHfGOhOKw0VODTxc38lzyj2HbM75SdRI
	 s6Y8kLjBwoeOg==
Message-ID: <7ac4676c-f68b-4cfd-9356-0f26f8215aed@kernel.org>
Date: Wed, 18 Mar 2026 14:08:10 +0800
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
Cc: chao@kernel.org, xiang@kernel.org, yifan.yfzhao@linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] erofs: harden h_shared_count in
 erofs_init_inode_xattrs()
To: Utkal Singh <singhutkal015@gmail.com>, linux-erofs@lists.ozlabs.org
References: <20260317152439.5738-1-singhutkal015@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260317152439.5738-1-singhutkal015@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:xiang@kernel.org,m:yifan.yfzhao@linux.dev,m:linux-kernel@vger.kernel.org,m:singhutkal015@gmail.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2824-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 476182B6349
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026/3/17 23:24, Utkal Singh wrote:
> `u8 h_shared_count` indicates the shared xattr count of an inode. It is
> read from the on-disk xattr ibody header, which should be corrupted if
> the size of the shared xattr array exceeds the space available in
> `xattr_isize`.
> 
> It does not cause harmful consequence (e.g. crashes), since the image is
> already considered corrupted, it indeed results in the silent processing
> of garbage metadata.
> 
> Let's harden it to report -EFSCORRUPTED earlier.
> 
> Signed-off-by: Utkal Singh <singhutkal015@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

