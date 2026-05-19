Return-Path: <linux-erofs+bounces-3461-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHa5EH7BDGqJlgUAu9opvQ
	(envelope-from <linux-erofs+bounces-3461-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 22:01:02 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8383C584695
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 22:01:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKlsl3HwJz2yCM;
	Wed, 20 May 2026 06:00:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::632" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779220859;
	cv=pass; b=HzPsTBbNDTrYUW54XuVLeFYY/VdD3Q+O7BeZNkBI+XnxzBpxc0zA0wKoLJ3H23Vrza3nFE/1DzYV5XrLkMbAisGSfRXRL49hWMcrSkPb5i+afNCRXEB+FieWGSeQHaVdOtklpLPleqfZqaNCjj2XrQaQm8syWApH4p0BnYGTNEknBqHWDOLla6p0RjEBAkD1L30otv3AgLwYZ3kILqbTIakiJsTowOt0YzuOfqfCE0jv4uzozC8pUytbKnE4+kQKEtxVRn+KrtZBtQH497mqCaVnYJmJQrC4YJGTvOCCs4w2/tWU9ZX5OcyXNCgXresK8uKwVWYBNIz2BbYihUXncw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779220859; c=relaxed/relaxed;
	bh=sWQr185us1DFSlKchLrpfMSQoSkpQKMiKjcWvQQMoeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMnSqxaTkNHJ7h9F7o+/VvYym6g+U/XVtic+dZseXyOWiICdJ2o2qkP96u+qw6XiHyJg7zmyAW4Yjpu2Gm72T/Idgmk63AE7jE3rAMuy9y1255HBXlCXRfPku9WjB8+w6zEXdeGCxecvFiaIS4UDtbex2y8cIhD7UNpt1y2qyuDn+GfP48fr6OFHzVamio708iDNnmKryZ3Fzau5oiV7I3HLJ8EcoznqlKU9jk6GbKszgspUDN0iwzbMmvEPPrifoEAWphPb9b8WODqD0lgz2utytR6a/EJj4GyVm5+YTmqc5M2HvHPOu+p96qyrYmcW0/yx9JTC6vf/mYAllqY5GA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PNA2nH8V; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=sjg@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PNA2nH8V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=sjg@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKlsk1F9pz2xwH
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 May 2026 06:00:58 +1000 (AEST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-bcc2b199c17so525726466b.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 19 May 2026 13:00:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779220855; cv=none;
        d=google.com; s=arc-20240605;
        b=GlHvkgn1o3JnWbDk7JXc3HCcH1iXuqVOkVONdHNb3zD6sGvP2GSldn+e9EB1rHdAaU
         p44lRl8nhZXAR0xGfMhjW6Yzud5VtyHkJsGPn3RyQULR6BXJOCNZM5zfwxh1yahgAm+d
         XlWK+a4zYCPqAgTqDihsAV66k7xJZxYvGnKSWHW7Y2nv+ErAS2ei5rbP2NRq3mKQm8N4
         vxOcFP092PH25RI+XG7FofVjKvelEyA82uiaxuh+Yuyxzhvef5C9p4sHFC3kj2RX5IJ7
         Lf1O9GPK/F8FTZyRs2oVHQkwqkd222YG9a7zYuNdGPMcPVk2cyeNZghNrPZBHfmC9uj9
         2d4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sWQr185us1DFSlKchLrpfMSQoSkpQKMiKjcWvQQMoeY=;
        fh=svMbc0WeRwaZoUKHLQmsvK90nkLHUtQ5O5qT344xX0w=;
        b=N0W9xxao7YMHcl8cNzM2djsFGWOYnossBJbGS8dpH0HhtfBbdiD4xqL4K10GgC2R1K
         /k3Lh3I5FiadcOE7h1q/ZFdXavYzmJyKpNiHKy/tW7rtSiHsZAcLqmyo6BjqH/91qO39
         Yr1vnAG12z57DzfJ0+Xn/WI1XZPuuyY/tLI6gpdY75uUlXj1xAN/tYzb4ZU/3MwrkbSl
         O3YT/mB8ccTZfl3u61myvGISjKcifS9cUNq1GLizGIQerHZ9LVCk4N83EJ1nmazQ1oYq
         h1hvU8BpXVsTy6EWFcIo2cAM+PsBPPwxX0NkmrLne/FlizDhRzFdgcNFWs1O10DFWP4E
         ZZ9w==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1779220855; x=1779825655; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sWQr185us1DFSlKchLrpfMSQoSkpQKMiKjcWvQQMoeY=;
        b=PNA2nH8VGwdE1Rl2mnuuvn1WwuXZNJCIuR6S1mzLl7dLtq9xXT/jGFrcLXqGCGuIRG
         C86ff77sMRj5E9u/Jhj+42hOFK40cFwdzC9aUKgMgM1+HDiq5Mp4MKo/U39E2jni+qFW
         Fh9Z1lD92m5IEGxpQ2YJyJHd3BpyztcZExdSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779220855; x=1779825655;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWQr185us1DFSlKchLrpfMSQoSkpQKMiKjcWvQQMoeY=;
        b=p76n3Q9m/NWCaMVRrZf8xQGr1gXBZrN0CDOGE9iozAVfCxHlE6SERoHxfE1jE1vujH
         N1gnN64TisfFwVSmMUVNY6hhwDlTugqEb9Wx3nAMqHmXeeOQcOjkupIALqVex9H8+j0y
         J8i/+4buenxtvkXoMQ0KM22r8tx00HXzleqEPfKVSfQUNQoDLlhYEh17+r5RMt4ri5aS
         tkeWqwwxpC2RCJA+OKKER7lQqnoKKqMGgKr96pCkWwWVsMLgdwVq978FtO8q3J8I2qYd
         I9BUFxIRoUV9Q5qx2rP3BudL28YhxUBWJpijo94sswc+PIaBeBYpNX0zzcxdP6TRVGrP
         tCTg==
X-Forwarded-Encrypted: i=1; AFNElJ+2mddhrshZxtyWjz1ZKPladwplfFHB0/Pk9B4OVB9YgX6NN/p45HAnN1npP2Ic6dZeADA0QqdXnmmy5g==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzUnBRCi3Jzu175/hXISMy+A4OMsecMXGWomcLb1Ujg3vTXYP3w
	6IADJJCFsV2benhUrQI8eWZSrFVBfp1t0kekyjY2dB9Sv+9BI0HtlB3ImO50pJ54HU2nVh7QD3C
	n+YtHl0uct8RH99wQa9wK2ZYNScLrZY74NpT4qazS
X-Gm-Gg: Acq92OEOPWi3NE4ik+dUPOyPvEC2lhm9QL59lAT15KfTT3W4ng75R7RZBD+/Z63qawL
	c5NjjilqW/VI78tDmRhp80btc+Lt4UhtnxYllAtDP/GT7krxavHR6Le7tG4NcIJgA6Y4+aANve4
	V/oBACkE1aMgCYecHjBiKhSW8NQGWdz2e6so49zi3RR8zLr57rRdUuL8bS3g6fP/H6Ut1FK7M9O
	3AGy3AJsTb/PU0rdPM3rr1+kfG3vYWZn9tIFAyHM8Rtqq1wJpC1vKOjTMHHeaimTa5aHp2n/+y+
	U5VFZw==
X-Received: by 2002:a17:906:730b:b0:bd5:7c3:ac9e with SMTP id
 a640c23a62f3a-bd517aa8105mr1142870366b.46.1779220855252; Tue, 19 May 2026
 13:00:55 -0700 (PDT)
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
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com> <20260518055728.178507-9-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260518055728.178507-9-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 May 2026 14:00:41 -0600
X-Gm-Features: AVHnY4KC0GDkeKmpBF700SEAxCy3NKu-3GUv9icrLt_Kv_du43jZqg81h26JHTg
Message-ID: <CAFLszThSuXELXXsdkz09FOtmL+XwE0gz-J8qeWR-MyAranzMxA@mail.gmail.com>
Subject: Re: [PATCH 8/9] test: env: allow optional date field in ls output assertion
To: heinrich.schuchardt@canonical.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
	Huang Jianan <jnhuang95@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
	Tony Dinh <mibodhi@gmail.com>, =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
	Francois Berder <fberder@outlook.fr>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
	Daniel Palmer <daniel@thingy.jp>, 
	Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
	Sughosh Ganu <sughosh.ganu@arm.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
	linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3461-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sjg@chromium.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:heinrich.schuchardt@canonical.com,m:trini@konsulko.com,m:sjg@chromium.org,m:jnhuang95@gmail.com,m:quentin.schulz@cherry.de,m:mibodhi@gmail.com,m:t.preissl@proton.me,m:fberder@outlook.fr,m:andrew.goodbody@linaro.org,m:daniel@thingy.jp,m:varadarajan.narayanan@oss.qualcomm.com,m:sughosh.ganu@arm.com,m:ilias.apalodimas@linaro.org,m:peng.fan@nxp.com,m:marek.vasut+renesas@mailbox.org,m:u-boot@lists.denx.de,m:linux-erofs@lists.ozlabs.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sjg@chromium.org,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[konsulko.com,chromium.org,gmail.com,cherry.de,proton.me,outlook.fr,linaro.org,thingy.jp,oss.qualcomm.com,arm.com,nxp.com,mailbox.org,lists.denx.de,lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs,renesas];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,chromium.org:dkim,canonical.com:email,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Queue-Id: 8383C584695
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Heinrich,

On 2026-05-18T05:57:19, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> test: env: allow optional date field in ls output assertion
>
> fs_ls_generic() now prints a date between the file size and filename
> when the filesystem sets FS_CAP_DATE (currently FAT and ext4).
>
> Adjust the assert in test_env.py().
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> test/py/tests/test_env.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/test/py/tests/test_env.py b/test/py/tests/test_env.py
> @@ -523,7 +523,7 @@ def test_env_ext4(state_test_env):
>          assert 'Loading Environment from EXT4... OK' in response
>
>          response = c.run_command('ext4ls host 0:0')
> -        assert '8192   uboot.env' in response
> +        assert(re.search('8192 .*uboot.env', ''.join(response)))

run_command() returns a string, not a list. So ''.join(response)
iterates the characters and rebuilds the string; it is a no-op. Please
drop the join() and pass response directly. Also, the trailing '.' in
uboot.env is a regex metacharacter - escape it as uboot\\.env.

Regards,
Simon

