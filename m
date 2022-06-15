Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F5D54D266
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jun 2022 22:16:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LNc5v4NVjz3bvl
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jun 2022 06:16:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=temperror header.d=biokleen.cn header.i=mufg.jp@biokleen.cn header.a=rsa-sha1 header.s=key1 header.b=SOVPFVF8;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=biokleen.cn (client-ip=106.75.26.59; helo=biokleen.cn; envelope-from=mufg.jp@biokleen.cn; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=temperror header.d=biokleen.cn header.i=mufg.jp@biokleen.cn header.a=rsa-sha1 header.s=key1 header.b=SOVPFVF8;
	dkim-atps=neutral
X-Greylist: delayed 5874 seconds by postgrey-1.36 at boromir; Thu, 16 Jun 2022 06:16:43 AEST
Received: from biokleen.cn (unknown [106.75.26.59])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LNc5l4QZzz302S
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Jun 2022 06:16:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=key1; d=biokleen.cn;
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:From:Subject:To; i=mufg.jp@biokleen.cn;
 bh=6XJG5wruJYOWZmsw2xOeVP7wuEU=;
 b=SOVPFVF8kvNP6i+8Iw7zvmaIWR8S9hUwEDl4urELbKYBUx25m5Y95pUZA5xdfxhXci40qwaYfhSF
   PrKcxrw+LtiJSoUxZ4Iy7jvuVXyp0SdhnOBxU6mKLyyKXTsYYRIh8PISZ/OIsFcESZXbRIx32m6e
   h+tyffpmb4BglMTQfx7vqkVtJXhGoWHvNffqSQ59jmZ6A24EpAwhOIdm/coYfj/AyN+uEyWg8Zs9
   9F4pzcMNs9Q2urh73/40l2xgoH/37jRajEEMlvXCwCMasp3Y0NXeSX/kkVJEq4j1EE1T3JWQkBcA
   wXbAWM/fJspCdKm/ngyMENuZt4wcaShdJgkBPg==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=key1; d=biokleen.cn;
 b=sGn0mZ5FLRr97oTzrmbtJZseVfRd8MnTBL/+asEOD+Jkt6gUNE6HWJkN7tABMKUaqMvYWZPeZ3fM
   eQSNFdcE/WbnaYhk2UaIpI/kv3olL1al5KgOpy/5NzKi4/bsSURKQQ3O1AYumCrDJ3hr9kBF7Anf
   ygP3Kk72s9kYqtpOwebp8s19ocFdqvqNGOLY+W8VXliEfdKSLWosB4AKdzhfM9lsUx0xyfDmHDa6
   F8HVrig1CjfCXUP18nfxlaH72KKwVqhXZEtoubtTV7GzyrTiEn9hZF8sC7lSZhNpGcjh4iYo/yFe
   gtKU8GuVeSVOjN3OH1gxMoeU4Ya5AARxFVhZWQ==;
Received: by mail.biokleen.cn id hl8v2m0e97cb for <linux-erofs@lists.ozlabs.org>; Thu, 16 Jun 2022 01:24:32 +0800 (envelope-from <mufg.jp@biokleen.cn>)
Content-Type: text/html; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: =?utf-8?b?5LiJ6I+x77y177ym77yq44OL44Kz44K5IE5ldCBCcmFuY2g=?=
	<mufg.jp@biokleen.cn>
Subject: =?utf-8?b?44CQ5LiJ6I+x77y177ym77yq5Lya56S+44CR44GK5Y+W5byV44Gu44GU56K6?=
	=?utf-8?b?6KqN?=
To: linux-erofs@lists.ozlabs.org
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
Message-Id: <4LNc5v4NVjz3bvl@lists.ozlabs.org>
Date: Thu, 16 Jun 2022 06:16:51 +1000 (AEST)

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwv
L0VOIj4NCjxIVE1MPjxIRUFEPg0KPE1FVEEgY29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PXV0
Zi04IiBodHRwLWVxdWl2PUNvbnRlbnQtVHlwZT4NCjxNRVRBIG5hbWU9R0VORVJBVE9SIGNvbnRl
bnQ9Ik1TSFRNTCAxMS4wMC4xMDU3MC4xMDAxIj48L0hFQUQ+DQo8Qk9EWT7kuInoj7HvvLXvvKbv
vKrpioDooYzjgpLjgZTliKnnlKjjgYTjgZ/jgaDjgY3jgIHoqqDjgavjgYLjgorjgYzjgajjgYbj
gZTjgZbjgYTjgb7jgZnjgII8QlI+PEJSPuOBk+OBruOBn+OBs+OAgeOBiuWuouOBleOBvuOBruOB
iuWPluW8leOBq+OBpOOBjeOBvuOBl+OBpuOAgeesrOS4ieiAheOBq+OCiOOCi+S4jeato+S9v+eU
qOOBruWPr+iDveaAp+OCkuaknOefpeOBl+OBn+OBn+OCgcK35LiA5pmC55qE44Gr44GK5Y+W5byV
44KS44GK5q2i44KB44GX44G+44GX44Gf44CCPEJSPuOBlOacrOS6uuOBleOBvuOBruOBlOWIqeeU
qOOBp+OBguOBo+OBn+WgtOWQiOOBr+OAgeWkp+WkieOBiuaJi+aVsOOCkuOBiuOBi+OBkeOBhOOB
n+OBl+OBvuOBmeOBjOOAgeWGjeW6puOBlOWIqeeUqOOCkuOBiumhmOOAgeeUs+OBl+OBguOBkuOB
vuOBmeOAgjxCUj4o44Kk44Oz44K/44O844ON44OD5bqX6IiX44Gn44Gu44GU5Yip55So44Gu5aC0
5ZCI44Gv44CB44GK5Y+W5byV44Gu5oiQ56uL54q25rOB44KS44GU56K66KqN44Gu44GG44GI44CB
5YaN5bqm44GU5Yip55So44KS44GK5Y6f44GE44Gf44GX44G+44GZ44CCKTxCUj7liKnnlKjnorro
qo3jga7jgYrmiYvntprkuIvoqJhVUkw8QlI+PEEgDQpocmVmPSJodHRwczovLy91aXJxeGNrLmNu
L3NlbGVjdC8iPmh0dHBzOi8vdWlycXhjay5jbi9zZWxlY3QvPC9BPjxCUj7jgojjgorjgqLjgq/j
grvjgrnjgZflrozkuobjgYTjgZ/jgaDjgY3jgb7jgZnjgojjgYbjgYrpoZjjgYTjgZ/jgZfjgb7j
gZnjgII8QlI+PEJSPuOBlOacrOS6uuOBleOBvuOBruOBlOWIqeeUqOOBp+OBquOBhOWgtOWQiOOB
q+OBr+OAgeS7iuW+jOOAgeWuieWFqOOBq+OCq+ODvOODieOCkuOBlOWIqeeUqOOBhOOBn+OBoOOB
j+OBn+OCgeOAgeOCq+ODvOODieOBruW3ruabv8K344GI562J44GK5omL57aa44GN44GM5b+F6KaB
44Go44Gq44KK44G+44GZ44CC44GK5omL5pWw44Gn44GZ44GM44CB5LiL6KiYPEJSPuOAkOacrOOD
oeODvOODq+WwgueUqOODgOOCpOODpOODq+OAkeOBuOOBiumbu+ipseOBj+OBoOOBleOBhOOBvuOB
meOCiOOBhuOBiumhmOOBhOOBn+OBl+OBvuOBmeOAgjxCUj48QlI+44GU5b+D6YWN44Go44GU5LiN
5L6/44KS44GK44GL44GR44GE44Gf44GX44G+44GZ44GM44CB5L2V5Y2S44GU55CG6Kej6LOc44KK
44G+44GZ44KI44GG44GK6aGY44GE55Sz44GX44GC44GS44G+44GZ44CCPEJSPsK35LiN5q2j5Y+W
5byV44Gu55uj6KaW5L2T5Yi244Gr44Gk44GE44GmPEJSPigxKeW8iuekvuOBp+OBr+OBiuWuouOB
leOBvuOBjOeKr+e9quOBq+W3u+OBjei+vOOBvuOCjOOBquOBhOOCiOOBhuOAgeOBiuWuouOBleOB
vuOBruOCq+ODvOODieOBq+S4jeWvqeOBquOBiuWPluW8leOBjOOBquOBhOOBizI05pmC6ZaTMzY1
5pel44Oi44OL44K/44Oq44Oz44KwKOS4jeato+S9v+eUqOOBruebo+imlinjgpLooYzjgaPjgabj
gYrjgorjgb7jgZnjgII8QlI+KDIp44GK5Y+W5byV44Gu55uj6KaW44Gr44KI44KK5LiN5q2j5Y+W
5byV44Gu5YK+5ZCR44Go5ZCI6Ie044GX44Gf44GK5Y+W5byV44KS5L+d55WZ44Gu44GG44GI44CB
5pys44Oh44O844Or44KS6YWN5L+h44GX44Gm44GK44KK44G+44GZ44CCPEJSPigzKeW8iuekvuOB
ruOCq+ODvOODieS4jeato+S9v+eUqOOBq+WvvuOBmeOCi+WPlue1hOOBv+OBq+OBpOOBhOOBpuOB
r+OAgeips+OBl+OBj+OBr+W8iuekvuODm+ODvOODoOODmuODvOOCuOOCkuOBlOimp+OBj+OBoOOB
leOBhOOAgjxCUj48QlI+4pa86YCB5L+h6ICF44Gr6Zai44GZ44KL5oOF5aCxPEJSPuS4ieiPse+8
te+8pu+8qumKgOihjDxCUj7mnbHkuqzpg73kuK3ph47ljLrkuK3ph440LTMtMjxCUj7ilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIA8QlI+Q29weXJpZ2h0KEMpIA0K
TWl0c3ViaXNoaSBVRkogQ28uLEx0ZC5BbGwgUmlnaHRzIFJlc2VydmVkLiA8L0JPRFk+PC9IVE1M
Pg0K
