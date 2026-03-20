Return-Path: <linux-erofs+bounces-2890-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gD2ELPuBvWk4+gIAu9opvQ
	(envelope-from <linux-erofs+bounces-2890-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 18:20:59 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8972DE801
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 18:20:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcq8l2R65z2ybQ;
	Sat, 21 Mar 2026 04:20:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::42f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774027255;
	cv=pass; b=oDeEkQfsv4bKf9scHr+JjBqsMzhwG4c98qtKFNo/WH64F3iI9d7e92DOtgLl3Jk1aRQ4P+QwtZbpNjdpmt5CmooszeDk+9gZx68g+0AthRhO8YbCUYMnuLKUfM2a/U2diN1JaJgKBcb9EmpquBWFZPKOweWgA9siKde4JgiMMJii7W0tIzw2wg0xwqACRIOI3Gi3pTTbREOMH/01QP5oLNxm5IfZFTL1dQ+rqhEyLr3/DM9L5bO40QppoDGUaAAcOut1bqJG+EWEr054sJ0ryM1yFCiUsVeDNorpMvjc1ShsSbLCNijoAC1qREaLj33UdsvmyK2re2YJRgYHpEDcUg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774027255; c=relaxed/relaxed;
	bh=5V7rOSLvHpo6Zu6dvAbiy5ttsAX2ZwlC8QPDM94Cf4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cizz+amePnXrvjMC+qYUMrkv3YZgcHJDnKYWB6IGB4GEEFC0Qjuaj5WEULHbUFefg8ICReCuZ+51T/pSVMRpIyTE8fGJtWnHgeLSeIvcthzoFcznsNqJWGjxEDqsWZQLNwMhOynFm52IBXouN/gpGQNK2ThTXhbKLnFZUEkJkNU6qLhkzOLedD0a9X7fifSHVfr3rlvvk9xI2CxGPrWYsNOaOM/f12PsyhisdsSKda5fbdSbwPaag7f59+tSUmtgAAbfAiQUxJDjMQ/NQxslBll9L2YApzTRyy+g/pqGFOAn6aWNZI9yzc0MKHMy1dFttLCkW6uocs3CP2r2ITOPhg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=T2KQS2pF; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=T2KQS2pF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcq8k05Z7z2yWK
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 04:20:52 +1100 (AEDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-43b4f48c47cso693718f8f.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 10:20:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774027244; cv=none;
        d=google.com; s=arc-20240605;
        b=Rl34mT1rX83+pq6nm/I9WGBmkkGFk3uxKTt0COActMmAvZK9pCDPPlgEm++XqOi9ah
         X5DKmGsDNzMZGp44+p2aajtUz4z7s1cSSE/AmbUsVK1FF6v6htcwgYxtHh5ImVR5RH06
         20owDiZwOh4l0FvIK7o2nsi5HNNrtES7vCl9odRTTB/yXTsq4g3og2Gn0164jsnAHZ38
         +srhivbonCXoyPf/chJr3I7PPI7ktzhhpfpxh4qPGTEHmAwYH0OlAxFqMYZ+EijgvghB
         03Pp1qjdLZCRS0dVEU2PavK2Gis90VAWbExJJSTUarXEmXxH4JJ9A9OEC4LRWxsbCwKm
         SfLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5V7rOSLvHpo6Zu6dvAbiy5ttsAX2ZwlC8QPDM94Cf4k=;
        fh=TC8dcaARiPNADrLwL3K5o+mdQHfHCtdWXIMVokGrY0I=;
        b=DqlwyFJyrYC31IE+laBkataeHwI69iFT13prO2flRiJmOJUzvIaAq3Qg8eFHAg+Ma2
         xo5N6MmOSNlwSq18eEBpAdcuAsrzJP6QDjw4ZtMpEpgrHRBaXRVf5P9Z7+669UZToABu
         WryVHWNHNsSQ6Mwp3nMIiAv8SS8yH5pW0vB8TwBGOjicxiVfpCAA05iUo0HXp5cPY3oa
         8k7ReYTVFVHq0OGhCXn8aTt2ua3twV/g/KB0CAx4y+ruj0waVmH7EC2m1sgnG52S82Cs
         3vz1ETCHAKwrBm1mxJncEfBUTPt0vkEqHxvNs+x+6oD44EJ6bdHmYp3zubpm7HMYBlLu
         4/0Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774027244; x=1774632044; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5V7rOSLvHpo6Zu6dvAbiy5ttsAX2ZwlC8QPDM94Cf4k=;
        b=T2KQS2pFKpCMkAhqJMdyJMkZCD0hrD56cxO06UlIuqDbNJPCP+Q4ZVwzwCwkb7dHCZ
         Fka7FXq2FCeVmreqGhLBxCgy+eeyjope8sjuUStjydpL+sW5iJaYyoRPsdti1mlsbVci
         guSjMPQTqi260CduTUC1+g3+FjD99zpQoUe1KdbR9hqXxNpWr/vPkBuBx5i3fzN33zzg
         kYfAfQ/aTxSL9VlywdH+kLmIJOh+XY3AXGQciPiRz34EUIYk2Z+/NG0wEHAinZpGZeZz
         6CP+oKkAwzVSX7Vi9oBA5hmEYjxroJ15KE3077xQ17A0fcTi3pbj37yCL0CeHkOVDbK8
         FVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774027244; x=1774632044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5V7rOSLvHpo6Zu6dvAbiy5ttsAX2ZwlC8QPDM94Cf4k=;
        b=lr0PxaFQMKaPjh+kks+PL43DR5aDyzSZFo7LzfPa3WcNfp8ou59j/rKGLc6hBheYJG
         P1C/gN7F/RyuIEqNeHXEl05MnegCMycARW8wpv019N5mFs0MW0anl0rT41YXtZhWLnfp
         62O2vDA3l4OPoCfAhp2l2pZ/wFiQ3tQTsyKQVR2lTMVNkbh3FtCtnvzzdZoLC//6DTBR
         WYeK0QXaSjyyyrzCE7G5day+Nbth7qNYK1jG1BQK00yPpuF1BwM8K8e8v2hIDD5sdRib
         o3lxIvSFwsN6ApJTNYaDcmG6YIqkFkVTLlDrSu80d2Bu/BJ8ZWxAGAtuX9Y4moXgMGb0
         02cw==
X-Gm-Message-State: AOJu0YypmxTfOW2T76Am2MMhnl6tN0GnnvkzenmfgrNPql71hFFNBC1x
	GLBOFaeXPWDHVmfFza1FXvG5sNJEOahDOZUcJnmVkg+salMuc07gXhNwMV2qudkvGCjHVJ1lUkg
	ogbOpVpudCFoVF6eadZsbTvmrYCeW2y4=
X-Gm-Gg: ATEYQzxjBAyRCueolrukI5BEUF9ErVzrgidgXOSi+9XJ5RB7PcYm9i/pEqY8Z7utfph
	i3MtoJT0eOoRAZlxNVmNa/cIh97JbXtSu7QHopD2E6lyjDSpPwB3EvLE9C3pNCoBt7pG92jxll6
	qpkLiH5lkERoOeWGWEANbromGjqi8tM7fQCfpTdIzQeO0lH0T59983y8wo1WBHCjIpO3rcKQiQr
	tD5vpSjK3vFjeuK55Xps9B7xXo/c3aWwvnhUjsB2I+Ez2RxXI1oaO6fT+UzdRrLzxdogsP32uTl
	CNDNkc4Y43FqdGBoLty0OWXgjPMkGdnfbtYfjRkBsjU6x6HT+Hh0
X-Received: by 2002:a05:6000:2dc2:b0:43b:6352:a262 with SMTP id
 ffacd0b85a97d-43b64286a5amr6859245f8f.41.1774027244208; Fri, 20 Mar 2026
 10:20:44 -0700 (PDT)
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
References: <20260320165200.1862-1-newajay.11r@gmail.com> <20260320170430.43337-1-nithurshen.dev@gmail.com>
In-Reply-To: <20260320170430.43337-1-nithurshen.dev@gmail.com>
From: Ajay Rajera <newajay.11r@gmail.com>
Date: Fri, 20 Mar 2026 22:50:30 +0530
X-Gm-Features: AaiRm53XNTkbZPotW91gJfo1KvUSFWBpmHo_01CXiZXGxuPWPESj70BWB5hPVGo
Message-ID: <CAMhhD9gyEkNO6ycBGqADyTCAhEHjbBPU-ZFB-LAZXQtZH+d_cQ@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: fix resource leaks and missing returns on
 error paths
To: Nithurshen <nithurshen.dev@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2890-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.997];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 4A8972DE801
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Yeah, I know that both changes are not related but the fixes are small
so I did it in just one patch.
Thanks, Ajay.

On Fri, 20 Mar 2026 at 22:34, Nithurshen <nithurshen.dev@gmail.com> wrote:
>
> Hi Ajay,
>
> I will test and verify this patch shortly.
> But, can you please send a v2 of this in two sperate patches with a
> cover letter, as both of your changes are completely unrelated to each
> other.
>
> Thanks and Regards
> Nithurshen

